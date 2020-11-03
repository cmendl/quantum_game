"""
Quantum game demo

This is a very prelimary draft...

@author: Christian B. Mendl
"""

import numpy as np
from enum import Enum
import pyglet
from pyglet.window import key
from pyglet.window import mouse


class TileTypes(Enum):
    """Types of tiles to assemble a level."""
    empty  = 0
    wall   = 1
    glass  = 2
    door   = 3
    button = 4

# width and height of a square tile, in pixels
tile_size = 64

# define world geometry
levelmap = np.array([
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 4, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 3, 0, 0, 0],
        [1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]], dtype=int)


class AABB(object):
    """Axis-aligned bounding box."""
    def __init__(self, xmin, xmax, ymin, ymax):
        self.xmin = xmin
        self.xmax = xmax
        self.ymin = ymin
        self.ymax = ymax

    def intersect(self, other):
        """Check intersection with another bounding box."""
        return ((self.xmin < other.xmax and self.xmax > other.xmin) and
                (self.ymin < other.ymax and self.ymax > other.ymin))

    def contains(self, x, y):
        """Test whether bounding box contains point (x, y)."""
        return ((self.xmin < x and x < self.xmax) and
                (self.ymin < y and y < self.ymax))


# axis-aligned bounding boxes
wall_aabbs   = []
glass_aabbs  = []
door_aabbs   = []
button_aabbs = []
for x in range(levelmap.shape[1]):
    for y in range(levelmap.shape[0]):
        if TileTypes(levelmap[y, x]) == TileTypes.wall:
            wall_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        elif TileTypes(levelmap[y, x]) == TileTypes.glass:
            glass_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        elif TileTypes(levelmap[y, x]) == TileTypes.door:
            door_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        elif TileTypes(levelmap[y, x]) == TileTypes.button:
            button_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))

button_pressed = len(button_aabbs) * [False]


class Directions(Enum):
    """The four cardinal directions."""
    east  = 0
    north = 1
    west  = 2
    south = 3


def movement_collision(box, direction, dist, world_boxes):
    assert dist >= 0
    # actual movement distance
    actualdist = dist
    if direction == Directions.east:
        movebox = AABB(box.xmax, box.xmax + dist, box.ymin, box.ymax)
        for wb in world_boxes:
            if movebox.intersect(wb):
                actualdist = min(actualdist, wb.xmin - box.xmax)
    elif direction == Directions.north:
        movebox = AABB(box.xmin, box.xmax, box.ymax, box.ymax + dist)
        for wb in world_boxes:
            if movebox.intersect(wb):
                actualdist = min(actualdist, wb.ymin - box.ymax)
    elif direction == Directions.west:
        movebox = AABB(box.xmin - dist, box.xmin, box.ymin, box.ymax)
        for wb in world_boxes:
            if movebox.intersect(wb):
                actualdist = min(actualdist, box.xmin - wb.xmax)
    elif direction == Directions.south:
        movebox = AABB(box.xmin, box.xmax, box.ymin - dist, box.ymin)
        for wb in world_boxes:
            if movebox.intersect(wb):
                actualdist = min(actualdist, box.ymin - wb.ymax)
    if actualdist < 0:
        print('Warning: negative movement distance, already intersecting with a world box before movement?')
    return actualdist


window = pyglet.window.Window(levelmap.shape[1]*tile_size, levelmap.shape[0]*tile_size)
window.config.alpha_size = 8


# set window background color to white
pyglet.gl.glClearColor(1, 1, 1, 1)


pyglet.resource.path = ['resources']
pyglet.resource.reindex()

brick_image = pyglet.resource.image('brick.png')
glass_image = pyglet.resource.image('glass.png')
button_red_image   = pyglet.resource.image('button_red.png')
button_green_image = pyglet.resource.image('button_green.png')

ket0_image = pyglet.resource.image('ket0.png')
ket1_image = pyglet.resource.image('ket1.png')

# 0 or 1
ket_selection = 0

# |0> "measurement probability"
ket0_prob = 0.5
# whether last wavefunction collapse was to |0> or |1>
ket_collapse = 0
oscillator_time = 0

# flash after wavefunction collapse
flash_active = False
flash_time = 0.
flash_duration = 3

game_over = False


# graphics

doors = [pyglet.resource.image('door{}.png'.format(i)) for i in range(9)]
door_open = pyglet.image.Animation.from_image_sequence(doors, duration=0.2, loop=False)
door_close = pyglet.image.Animation.from_image_sequence(reversed(doors), duration=0.2, loop=False)

main_batch = pyglet.graphics.Batch()

levelmap_sprites = []
door_open_sprites = []
door_close_sprites = []
button_red_sprites = []
button_green_sprites = []
for x in range(levelmap.shape[1]):
    for y in range(levelmap.shape[0]):
        if TileTypes(levelmap[y, x]) == TileTypes.wall:
            levelmap_sprites.append(pyglet.sprite.Sprite(brick_image, x*tile_size, y*tile_size, batch=main_batch))
        elif TileTypes(levelmap[y, x]) == TileTypes.glass:
            levelmap_sprites.append(pyglet.sprite.Sprite(glass_image, x*tile_size, y*tile_size, batch=main_batch))
        elif TileTypes(levelmap[y, x]) == TileTypes.door:
            door_open_sprites. append(pyglet.sprite.Sprite(door_open,  x*tile_size, y*tile_size))
            door_close_sprites.append(pyglet.sprite.Sprite(door_close, x*tile_size, y*tile_size))
        elif TileTypes(levelmap[y, x]) == TileTypes.button:
            button_red_sprites.append(pyglet.sprite.Sprite(button_red_image, x*tile_size, y*tile_size))
            button_green_sprites.append(pyglet.sprite.Sprite(button_green_image, x*tile_size, y*tile_size))

ket_sprites = [pyglet.sprite.Sprite(ket0_image, round(7.1*tile_size), round(2.5*tile_size), batch=main_batch),
               pyglet.sprite.Sprite(ket1_image, round(8.5*tile_size), round(1.8*tile_size), batch=main_batch)]

wire_batch = pyglet.graphics.Batch()
wire_batch.add(5, pyglet.gl.GL_LINE_STRIP, None,
    ('v2f',
        ( 2.0*tile_size, 2.5*tile_size,
          0.5*tile_size, 2.5*tile_size,
          0.5*tile_size, 6.5*tile_size,
         10.5*tile_size, 6.5*tile_size,
         10.5*tile_size, 4.0*tile_size)),
    ('c3B', (0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0)))


doc = pyglet.text.decode_text('Use arrow keys to move |0> or |1>,\nclick to select |0> or |1>.\nHit SPACE to measure.')
doc.set_style(0, len(doc.text), {'color': (0, 0, 0, 255)})
instructions = pyglet.text.layout.TextLayout(doc, 400, 50, multiline=True)
instructions.x = 5.4*tile_size
instructions.y = 5.0*tile_size
goal_label = pyglet.text.Label('Bring |0> and |1> here!', x=11.2*tile_size, y=3.5*tile_size, color=(0, 0, 255, 255), anchor_y='center')
game_over_label = pyglet.text.Label("Congrats, you've solved it!", font_size=22, x=window.width/2, y=window.height/2, color=(255, 0, 0, 255), anchor_x='center', anchor_y='center')


@window.event
def on_key_press(symbol, modifiers):
    global ket_collapse
    global ket_selection
    global flash_active, flash_time
    if symbol == key.SPACE:
        if not flash_active:
            flash_active = True
            flash_time = 0.
            # wavefunction collapse
            ket_collapse = np.random.choice(2, p=(ket0_prob, 1 - ket0_prob))
            ket_sprites[1-ket_collapse].x = ket_sprites[ket_collapse].x
            ket_sprites[1-ket_collapse].y = ket_sprites[ket_collapse].y
    elif symbol == key._0:
        print('Selecting |0>...')
        ket_selection = 0
    elif symbol == key._1:
        print('Selecting |1>...')
        ket_selection = 1

keys = key.KeyStateHandler()
window.push_handlers(keys)


@window.event
def on_mouse_press(x, y, button, modifiers):
    global ket_selection
    if button == mouse.LEFT:
        #print('The left mouse button was pressed at ({}, {}).'.format(x, y))
        for i in range(2):
            box = AABB(ket_sprites[i].x, ket_sprites[i].x + ket_sprites[i].image.width, ket_sprites[i].y, ket_sprites[i].y + ket_sprites[i].image.height)
            if box.contains(x, y):
                print('Selecting |{}>...'.format(i))
                ket_selection = i

@window.event
def on_draw():
    window.clear()
    pyglet.gl.glEnable(pyglet.gl.GL_BLEND)
    pyglet.gl.glBlendFunc(pyglet.gl.GL_SRC_ALPHA, pyglet.gl.GL_ONE_MINUS_SRC_ALPHA)

    pyglet.gl.glLineWidth(2.0)
    pyglet.gl.glLineStipple(1, 0x3F07);
    pyglet.gl.glEnable(pyglet.gl.GL_LINE_STIPPLE);

    global button_pressed

    if button_pressed[0]:
        door_open_sprites[0].draw()
    else:
        door_close_sprites[0].draw()

    for i in range(len(button_pressed)):
        if button_pressed[i]:
            button_green_sprites[i].draw()
        else:
            button_red_sprites[i].draw()

    global ket0_prob
    ket_sprites[0].opacity = int(255 * ket0_prob)
    ket_sprites[1].opacity = int(255 * (1 - ket0_prob))

    instructions.draw()
    goal_label.draw()
    main_batch.draw()
    wire_batch.draw()
    if game_over:
        game_over_label.draw()

    # draw overall "flash"
    global flash_active, flash_time, flash_duration
    if flash_active:
        brightness = np.arctan(15 * (1 - flash_time/flash_duration)) / (0.5*np.pi)
        width, height = window.get_size()
        pyglet.graphics.draw_indexed(4, pyglet.gl.GL_TRIANGLES,
            [0, 1, 2, 0, 2, 3],
            ('v2i', (0, 0, 0, height, width, height, width, 0)),
            ('c4f', (
                    1., 1., 1., brightness,
                    1., 1., 1., brightness,
                    1., 1., 1., brightness,
                    1., 1., 1., brightness)))


def update(dt):

    global ket_selection
    global ket0_prob, ket_collapse, oscillator_time
    global button_pressed
    global wall_aabbs, glass_aabbs, door_aabbs, button_aabbs
    global ket_sprites

    oscillator_time += dt
    # avoid eventual overflow
    if oscillator_time > 2:
        oscillator_time -= 2

    global flash_active, flash_time, flash_duration
    if flash_active:
        flash_time += dt
        if flash_time > flash_duration:
            # also reset oscillator
            oscillator_time = flash_time - flash_duration
            flash_active = False
            flash_time = 0

    if flash_active:
        if ket_collapse == 0:
            ket0_prob = 1 - 0.5 * flash_time/flash_duration
        else:
            ket0_prob = 0.5 * flash_time/flash_duration
    else:
        ket0_prob = 0.5 + (2*ket_collapse - 1) * 0.25*np.sin(2*np.pi * 0.5*oscillator_time)

    i = ket_selection
    aabbs = []
    if i == 0:
        aabbs += wall_aabbs + glass_aabbs
    elif i == 1:
        aabbs += wall_aabbs
    if not button_pressed[0]:
        aabbs += door_aabbs[:1]

    # bounding box of player sprite
    box = AABB(ket_sprites[i].x, ket_sprites[i].x + ket_sprites[i].image.width, ket_sprites[i].y, ket_sprites[i].y + ket_sprites[i].image.height)
    if keys[key.LEFT]:
        dist = movement_collision(box, Directions.west, 2, aabbs)
        ket_sprites[i].x -= dist
    elif keys[key.RIGHT]:
        dist = movement_collision(box, Directions.east, 2, aabbs)
        ket_sprites[i].x += dist
    elif keys[key.UP]:
        dist = movement_collision(box, Directions.north, 2, aabbs)
        ket_sprites[i].y += dist
    elif keys[key.DOWN]:
        dist = movement_collision(box, Directions.south, 2, aabbs)
        ket_sprites[i].y -= dist

    button_pressed_prev = button_pressed
    button_pressed = len(button_aabbs) * [False]
    for i in range(2):
        box = AABB(ket_sprites[i].x, ket_sprites[i].x + ket_sprites[i].image.width, ket_sprites[i].y, ket_sprites[i].y + ket_sprites[i].image.height)
        for j in range(len(button_pressed)):
            if box.intersect(button_aabbs[j]):
                button_pressed[j] = True

    if button_pressed[0] != button_pressed_prev[0]:
        # restart animation
        door_open_sprites[0]  = pyglet.sprite.Sprite(door_open,   door_open_sprites[0].x,  door_open_sprites[0].y)
        door_close_sprites[0] = pyglet.sprite.Sprite(door_close, door_close_sprites[0].x, door_close_sprites[0].y)

    global game_over
    if not game_over:
        game_over = ket_sprites[0].x > 11.5*tile_size and ket_sprites[1].x > 11.5*tile_size


def main():
    # update the game 50 times per second
    pyglet.clock.schedule_interval(update, 1 / 50.0)
    pyglet.app.run()


if __name__ == '__main__':
    main()
