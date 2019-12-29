"""
Quantum teleportation game demo

@author: Christian B. Mendl
"""

import numpy as np
import itertools
from enum import IntEnum
import pyglet
from pyglet.window import key


#==============================================================================
# Level geometry

class TileTypes(IntEnum):
    """Types of tiles to assemble a level."""
    empty     = 0
    wall      = 1
    efield_l  = 2
    efield_r  = 4
    efield_u  = 8
    efield_d  = 16
    entangler = 32
    button    = 64
    door_l    = 128
    door_r    = 256
    door_u    = 512
    door_d    = 1024


# width and height of a square tile, in pixels
tile_size = 64

# define world geometry
levelmap = np.flipud(np.array([
        [  1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1],
        [  1,   0,   0,   0,   0,   1,   0,   0,   0,   0,   0,   0,   0,   1],
        [  1,   0,   0,   0,   0, 130,   0,   0,   0,   0,   0,   0,   0,   1],
        [  1,   0,   0,   0,   0,   1,   1,   1,   1,   1,   1,   0,   0,   1],
        [  1,   1,   1,   1,   1,   1,   0,   0,   0,   0,   0,   0,   0,   1],
        [  1,   0,   0,   0,   0,   2,   0,   0,   0,   0,   0,   0,   0,   1],
        [  1,  64,   0,   0,   0,   1,   1,   1,   1,   8,   1,   1,   1,   1],
        [  1,   0,   0,   0,   0,   1,   0,   0,   0,   0,   0,   0,   0,   1],
        [  1,   0,   0,   0,   0,  32,   0,   0,   0,   0,   0,   0,  64,   1],
        [  1,   0,   0,   0,  64,   1,   0,   0,   0,   0,   0,   0,   0,   1],
        [  1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1]], dtype=int))


#==============================================================================
# Movement and collision detection

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
wall_aabbs     = []
efield_l_aabbs = []
efield_r_aabbs = []
efield_u_aabbs = []
efield_d_aabbs = []
button_aabbs   = []
door_aabbs     = []
for x in range(levelmap.shape[1]):
    for y in range(levelmap.shape[0]):
        if levelmap[y, x] & (int(TileTypes.wall) | int(TileTypes.entangler)):
            wall_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.efield_l):
            efield_l_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.efield_r):
            efield_r_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.efield_u):
            efield_u_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.efield_d):
            efield_d_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.button):
            button_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.door_l):
            door_aabbs.append(AABB(x*tile_size, (x + 0.5)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.door_r):
            door_aabbs.append(AABB((x + 0.5)*tile_size, (x + 1)*tile_size, y*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.door_u):
            door_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, (y + 0.5)*tile_size, (y + 1)*tile_size))
        if levelmap[y, x] & int(TileTypes.door_d):
            door_aabbs.append(AABB(x*tile_size, (x + 1)*tile_size, y*tile_size, (y + 0.5)*tile_size))

button_pressed = len(button_aabbs) * [False]
door_open = len(door_aabbs) * [False]


def aabb_movement_collision_east(box, world_boxes, dist):
    """
    Compute maximal movement distance when avoiding world box intersection,
    for axis-aligned movement direction to the east.
    """
    assert dist >= 0
    # actual movement distance
    actualdist = dist
    # whether we detect an intersection with a world box
    its = False
    movebox = AABB(box.xmax, box.xmax + dist, box.ymin, box.ymax)
    for wb in world_boxes:
        if movebox.intersect(wb):
            actualdist = min(actualdist, wb.xmin - box.xmax)
            its = True
    if actualdist < 0:
        print('Warning: negative movement distance, already intersecting with a world box before movement?')
    return actualdist, its

def aabb_movement_collision_west(box, world_boxes, dist):
    """
    Compute maximal movement distance when avoiding world box intersection,
    for axis-aligned movement direction to the west.
    """
    assert dist >= 0
    # actual movement distance
    actualdist = dist
    # whether we detect an intersection with a world box
    its = False
    movebox = AABB(box.xmin - dist, box.xmin, box.ymin, box.ymax)
    for wb in world_boxes:
        if movebox.intersect(wb):
            actualdist = min(actualdist, box.xmin - wb.xmax)
            its = True
    if actualdist < 0:
        print('Warning: negative movement distance, already intersecting with a world box before movement?')
    return actualdist, its

def aabb_movement_collision_north(box, world_boxes, dist):
    """
    Compute maximal movement distance when avoiding world box intersection,
    for axis-aligned movement direction to the north.
    """
    assert dist >= 0
    # actual movement distance
    actualdist = dist
    # whether we detect an intersection with a world box
    its = False
    movebox = AABB(box.xmin, box.xmax, box.ymax, box.ymax + dist)
    for wb in world_boxes:
        if movebox.intersect(wb):
            actualdist = min(actualdist, wb.ymin - box.ymax)
            its = True
    if actualdist < 0:
        print('Warning: negative movement distance, already intersecting with a world box before movement?')
    return actualdist, its

def aabb_movement_collision_south(box, world_boxes, dist):
    """
    Compute maximal movement distance when avoiding world box intersection,
    for axis-aligned movement direction to the south.
    """
    assert dist >= 0
    # actual movement distance
    actualdist = dist
    # whether we detect an intersection with a world box
    its = False
    movebox = AABB(box.xmin, box.xmax, box.ymin - dist, box.ymin)
    for wb in world_boxes:
        if movebox.intersect(wb):
            actualdist = min(actualdist, box.ymin - wb.ymax)
            its = True
    if actualdist < 0:
        print('Warning: negative movement distance, already intersecting with a world box before movement?')
    return actualdist, its

def aabb_movement_collision(box, world_boxes, dpos):
    """
    Update movement vector `dpos` when avoiding axis-aligned world box intersection.
    """
    its = False
    if dpos[0] < 0:
        d, its = aabb_movement_collision_west(box, world_boxes, -dpos[0])
        dpos[0] = -d
    elif dpos[0] > 0:
        d, its = aabb_movement_collision_east(box, world_boxes, dpos[0])
        dpos[0] = d
    # separate collision detection into x- and y-direction
    if dpos[1] > 0:
        d, its = aabb_movement_collision_north(box, world_boxes, dpos[1])
        dpos[1] = d
    elif dpos[1] < 0:
        d, its = aabb_movement_collision_south(box, world_boxes, -dpos[1])
        dpos[1] = -d
    return its


def physics_update(pos, vel, dt, size=0.7*tile_size, wallcollision=True, delta_pos=np.zeros(2), gammafrict=5):
    """Update for a time step `dt` resulting from acceleration by E-fields and collisions with doors or walls."""

    # bounding box
    box = AABB(pos[0] - 0.5*size, pos[0] + 0.5*size,
               pos[1] - 0.5*size, pos[1] + 0.5*size)

    inside_field = False

    # acceleration by E-fields
    acc = 300
    if not inside_field:
        for ea in efield_l_aabbs:
            if box.intersect(ea):
                vel[0] -= dt*acc
                inside_field = True
                break
    if not inside_field:
        for ea in efield_r_aabbs:
            if box.intersect(ea):
                vel[0] += dt*acc
                inside_field = True
                break
    if not inside_field:
        for ea in efield_u_aabbs:
            if box.intersect(ea):
                vel[1] += dt*acc
                inside_field = True
                break
    if not inside_field:
        for ea in efield_d_aabbs:
            if box.intersect(ea):
                vel[1] -= dt*acc
                inside_field = True
                break

    # imitate friction
    if not inside_field:
        vel *= np.exp(-gammafrict*dt)
        if np.linalg.norm(vel) < 1e-3:
            vel[:] = 0

    # proposed update of position
    dpos = dt*vel + delta_pos
    # reset velocity in case of intersection to avoid run-away accumulation when inside an E-field
    if wallcollision:
        its = aabb_movement_collision(box, wall_aabbs, dpos)
        if its: vel[:] = 0
    closed_doors = []
    for i in range(len(door_aabbs)):
        if not door_open[i]:
            closed_doors.append(door_aabbs[i])
    its = aabb_movement_collision(box, closed_doors, dpos)
    if its: vel[:] = 0
    # bias shift to avoid running into obstacles
    dpos[0] -= np.sign(dpos[0])*1e-10
    dpos[1] -= np.sign(dpos[1])*1e-10

    pos += dpos


#==============================================================================
# Game logic

class EntanglerState(IntEnum):
    inactive  = 0
    unfolding = 1
    active    = 2

class Entangler(object):
    """'Entangler' generating entangled qubit pairs for quantum teleportation."""

    _show_time  = 0.6
    _strob_time = 1.5

    def __init__(self, x, y, span=100):
        self.sourcepos = np.array([x, y])
        # distance of one qubit from the entangler when unfolded
        self.span = span
        self.reset()

    def reset(self):
        self.state = EntanglerState.inactive
        self.qpos = [self.sourcepos.copy(), self.sourcepos.copy()]
        self.qvel = [np.zeros(2), np.zeros(2)]
        self.show = False
        self.bloch_vec = np.zeros(3)
        self._timer = 0
        self._unfold_timer = 0
        self.entangled = False
        # stroboscope index, only used if 'entangled'
        self.stroboscope_idx = 0

    def activate(self):
        """Activate the entangler (start generating an entangled qubit pair)."""
        if self.state == EntanglerState.inactive:
            self.state = EntanglerState.unfolding
            self._unfold_timer = 1
            self.show = True
            self.qvel[0][0] = -100
            self.qvel[1][0] =  100
            self._timer = self._show_time
            # draw new random Bloch vector
            self.bloch_vec = np.random.normal(size=3)
            self.bloch_vec /= np.linalg.norm(self.bloch_vec)

    def update(self, dt):
        """Update for a time step 'dt'."""
        if self.state == EntanglerState.unfolding:
            self._unfold_timer -= dt
            # check if unfolding is completed
            if self._unfold_timer <= 0:
                self.state = EntanglerState.active

        if self.state != EntanglerState.inactive:
            for i in range(2):
                physics_update(self.qpos[i], self.qvel[i], dt, wallcollision=(self.state == EntanglerState.active), gammafrict=0.8)

            self._timer -= dt
            if self.entangled:
                if self._timer <= 0:
                    self.stroboscope_idx = (self.stroboscope_idx + 1) % 8
                    # set new timer
                    self._timer = self._strob_time
            else:
                if self._timer <= 0:
                    # switch whether to show Bloch vector
                    self.show = not self.show
                    if self.show:
                        # set new timer
                        self._timer = self._show_time
                        # draw new random Bloch vector
                        self.bloch_vec = np.random.normal(size=3)
                        self.bloch_vec /= np.linalg.norm(self.bloch_vec)
                    else:
                        # set new timer
                        self._timer = 2 + 1.5*np.random.rand()

entanglers = []
for x in range(levelmap.shape[1]):
    for y in range(levelmap.shape[0]):
        if levelmap[y, x] & int(TileTypes.entangler):
            entanglers.append(Entangler((x + 0.5)*tile_size, (y + 0.5)*tile_size))


player_entangler = None
# which one of the two qubits
player_entangler_qindex = -1

# player position and velocity
player_pos = np.array([3.5*tile_size, 4*tile_size])
player_vel = np.zeros(2)


# Bloch sphere representation
qubit_theta = 0
qubit_theta_dir = 1     # whether currently increasing or decreasing
qubit_phi = 0


# flash after measurement / wavefunction collapse
flash_active = False
flash_time = 0.
flash_duration = 3


game_over = False


#==============================================================================
# Graphics and rendering

window = pyglet.window.Window(levelmap.shape[1]*tile_size, levelmap.shape[0]*tile_size)
window.config.alpha_size = 8

# set window background color to white
pyglet.gl.glClearColor(1, 1, 1, 1)


pyglet.resource.path = ['resources']
pyglet.resource.reindex()

brick_image = pyglet.resource.image('brick.png')
efield_l_image = pyglet.resource.image('efield_left.png')
efield_r_image = pyglet.resource.image('efield_right.png')
efield_u_image = pyglet.resource.image('efield_up.png')
efield_d_image = pyglet.resource.image('efield_down.png')
entangler_image = pyglet.resource.image('entangler.png')
button_red_image   = pyglet.resource.image('button_red.png')
button_green_image = pyglet.resource.image('button_green.png')
bloch_sphere_image = pyglet.resource.image('bloch_sphere.png')

doors = [pyglet.resource.image('door{}.png'.format(i)) for i in range(9)]
# TODO: also support door_r, door_u, door_d
door_l_open_anim  = pyglet.image.Animation.from_image_sequence(doors, period=0.2, loop=False)
door_l_close_anim = pyglet.image.Animation.from_image_sequence(reversed(doors), period=0.2, loop=False)

main_batch = pyglet.graphics.Batch()

levelmap_sprites = []
button_red_sprites = []
button_green_sprites = []
door_open_sprites = []
door_close_sprites = []
for x in range(levelmap.shape[1]):
    for y in range(levelmap.shape[0]):
        if levelmap[y, x] & int(TileTypes.wall):
            levelmap_sprites.append(pyglet.sprite.Sprite(brick_image, x*tile_size, y*tile_size, batch=main_batch))
        if levelmap[y, x] & int(TileTypes.efield_l):
            levelmap_sprites.append(pyglet.sprite.Sprite(efield_l_image, x*tile_size, y*tile_size, batch=main_batch))
        if levelmap[y, x] & int(TileTypes.efield_r):
            levelmap_sprites.append(pyglet.sprite.Sprite(efield_r_image, x*tile_size, y*tile_size, batch=main_batch))
        if levelmap[y, x] & int(TileTypes.efield_u):
            levelmap_sprites.append(pyglet.sprite.Sprite(efield_u_image, x*tile_size, y*tile_size, batch=main_batch))
        if levelmap[y, x] & int(TileTypes.efield_d):
            levelmap_sprites.append(pyglet.sprite.Sprite(efield_d_image, x*tile_size, y*tile_size, batch=main_batch))
        if levelmap[y, x] & int(TileTypes.entangler):
            levelmap_sprites.append(pyglet.sprite.Sprite(entangler_image, x*tile_size, y*tile_size, batch=main_batch))
        if levelmap[y, x] == TileTypes.button:
            button_red_sprites.append(pyglet.sprite.Sprite(button_red_image, x*tile_size, y*tile_size))
            button_green_sprites.append(pyglet.sprite.Sprite(button_green_image, x*tile_size, y*tile_size))
        if levelmap[y, x] & int(TileTypes.door_l):
            door_open_sprites. append(pyglet.sprite.Sprite(door_l_open_anim,  x*tile_size, y*tile_size))
            door_close_sprites.append(pyglet.sprite.Sprite(door_l_close_anim, x*tile_size, y*tile_size))
        # TODO: also support door_r, door_u, door_d

bloch_sphere_sprite = pyglet.sprite.Sprite(bloch_sphere_image, 0, 0)

wire_door_batch = pyglet.graphics.Batch()
wire_door_batch.add(5, pyglet.gl.GL_LINE_STRIP, None,
    ('v2f',
        ( 1.0*tile_size,  4.5*tile_size,
          0.5*tile_size,  4.5*tile_size,
          0.5*tile_size, 10.5*tile_size,
          5.2*tile_size, 10.5*tile_size,
          5.2*tile_size,  9.0*tile_size)),
    ('c3B', (0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0)))

wire_entangler_batch = pyglet.graphics.Batch()
wire_entangler_batch.add(8, pyglet.gl.GL_LINE_STRIP, None,
    ('v2f',
        ( 5.5*tile_size,  2.0*tile_size,
          5.5*tile_size,  1.5*tile_size,
          5.0*tile_size,  1.5*tile_size,
          5.5*tile_size,  1.5*tile_size,
          5.5*tile_size,  0.5*tile_size,
         13.5*tile_size,  0.5*tile_size,
         13.5*tile_size,  2.5*tile_size,
         13.0*tile_size,  2.5*tile_size)),
    ('c3B', (0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0,
             0, 255, 0)))

doc_move_label     = pyglet.text.Label('Use arrow keys to move!',               x=3.0*tile_size, y=5.5*tile_size, color=(0, 0, 255, 255), anchor_x='center', anchor_y='center')
doc_teleport_label = pyglet.text.Label('Hit SPACE to teleport when entangled!', x=9.5*tile_size, y=3.5*tile_size, color=(0, 0, 255, 255), anchor_x='center', anchor_y='center')
goal_label         = pyglet.text.Label('Bring player here!',                    x=3.0*tile_size, y=8.5*tile_size, color=(0, 0, 255, 255), anchor_x='center', anchor_y='center')
game_over_label    = pyglet.text.Label("Congrats, you've solved it!",           x=3.0*tile_size, y=8.5*tile_size, color=(255, 0, 0, 255), anchor_x='center', anchor_y='center')

class MessageState(IntEnum):
    """Message display state."""
    nascent = 0
    display = 1
    hidden  = 2

show_doc_move     = MessageState.display
show_doc_teleport = MessageState.nascent
show_goal         = MessageState.display
show_game_over    = MessageState.nascent


def draw_bloch(center, sprite, r, color=(0, 1, 0)):
    """Draw the Bloch sphere and vector 'r'."""
    sprite.x = center[0] - sprite.image.width/2
    sprite.y = center[1] - sprite.image.height/2
    sprite.draw()
    # fast return if Bloch vector is 'None'
    if r is None: return
    # Bloch sphere radius, in pixels
    radius = 28
    btip = (center[0] + radius*r[1], center[1] + radius*r[2])
    # draw Bloch vector tip point as small disk
    ntip = 16
    tiptriind  = tuple(itertools.chain(*[[ntip, i, (i+1) % ntip] for i in range(ntip)]))
    tipcircind = tuple(itertools.chain(*[[i, (i+1) % ntip] for i in range(ntip)]))
    tipverts = ('v2f',
        tuple(itertools.chain(
            *[[btip[0] + (4 + 1.5*r[0])*np.cos(2*np.pi*i/ntip),
               btip[1] + (4 + 1.5*r[0])*np.sin(2*np.pi*i/ntip)] for i in range(ntip)])) + btip)
    pyglet.gl.glLineWidth(1.0)
    if r[0] >= 0:
        # draw vector shaft first, then tip disk
        pyglet.graphics.draw(2, pyglet.gl.GL_LINES,
            ('v2f', center + btip),
            ('c3B', 2*(0, 0, 0)))
        pyglet.graphics.draw_indexed(ntip + 1, pyglet.gl.GL_TRIANGLES, tiptriind,
                                     tipverts, ('c3f', (ntip + 1)*tuple(color)))
        pyglet.graphics.draw_indexed(ntip + 1, pyglet.gl.GL_LINES, tipcircind,
                                     tipverts, ('c3f', (ntip + 1)*(0, 0, 0)))
    else:
        # draw tip disk first, then vector shaft
        pyglet.graphics.draw_indexed(ntip + 1, pyglet.gl.GL_TRIANGLES, tiptriind,
                                     tipverts, ('c3f', (ntip + 1)*tuple(color)))
        pyglet.graphics.draw_indexed(ntip + 1, pyglet.gl.GL_LINES, tipcircind,
                                     tipverts, ('c3f', (ntip + 1)*(0, 0, 0)))
        pyglet.graphics.draw(2, pyglet.gl.GL_LINES,
            ('v2f', center + btip),
            ('c3B', 2*(0, 0, 0)))


#==============================================================================
# Event listeners and integration of all modules

@window.event
def on_key_press(symbol, modifiers):
    global flash_active, flash_time
    global player_pos
    global player_entangler, player_entangler_qindex
    global show_doc_move, show_doc_teleport
    if symbol == key.SPACE:
        if (player_entangler is not None) and (not flash_active):
            # teleport; flash symbolizes measurement and wavefunction collapse
            flash_active = True
            flash_time = 0.
            player_pos = player_entangler.qpos[1 - player_entangler_qindex]
            player_entangler.reset()
            player_entangler = None
            player_entangler_qindex = -1
            show_doc_teleport = MessageState.hidden
    elif symbol == key.LEFT or symbol == key.RIGHT or symbol == key.UP or symbol == key.DOWN:
        show_doc_move = MessageState.hidden

keys = key.KeyStateHandler()
window.push_handlers(keys)


def spherical_to_cartesian(theta, phi):
    return np.array([np.cos(phi)*np.sin(theta), np.sin(phi)*np.sin(theta), np.cos(theta)])

@window.event
def on_draw():

    window.clear()
    pyglet.gl.glEnable(pyglet.gl.GL_BLEND)
    pyglet.gl.glBlendFunc(pyglet.gl.GL_SRC_ALPHA, pyglet.gl.GL_ONE_MINUS_SRC_ALPHA)

    # labels
    if show_doc_move == MessageState.display:
        doc_move_label.draw()
    if show_doc_teleport == MessageState.display:
        doc_teleport_label.draw()
    if show_goal == MessageState.display:
        goal_label.draw()
    if show_game_over == MessageState.display:
        game_over_label.draw()

    main_batch.draw()
    pyglet.gl.glLineWidth(2.0)
    wire_door_batch.draw()
    wire_entangler_batch.draw()
    pyglet.gl.glLineWidth(1.0)

    global door_open
    for i in range(len(door_open)):
        if door_open[i]:
            door_open_sprites[i].draw()
        else:
            door_close_sprites[i].draw()

    global button_pressed
    for i in range(len(button_pressed)):
        if button_pressed[i]:
            button_green_sprites[i].draw()
        else:
            button_red_sprites[i].draw()


    global player_pos
    global qubit_theta, qubit_phi

    global entanglers
    is_entangled = False
    for ent in entanglers:
        if ent.state != EntanglerState.inactive:
            if ent.entangled:
                # Bloch vector
                r = spherical_to_cartesian(qubit_theta, qubit_phi)
                # player qubit north or south pole, static entangler qubit north or south pole, first or second entangler qubit rotating, Bloch vector transformation
                strob_map = [
                        ( 1,  1, 0, np.array([-1,  1, -1])), # - beta  |000> + alpha |001>; rotate by angle pi around y-axis
                        ( 1, -1, 1, np.array([ 1,  1,  1])), # + alpha |001> + beta  |011>; use Bloch vector as-is
                        ( 1, -1, 0, np.array([-1, -1,  1])), # - alpha |010> + beta  |011>; rotate by angle pi around z-axis
                        ( 1,  1, 1, np.array([ 1, -1, -1])), # - beta  |000> - alpha |010>; rotate by angle pi around x-axis
                        (-1,  1, 0, np.array([ 1, -1, -1])), # + beta  |100> + alpha |101>; rotate by angle pi around x-axis
                        (-1, -1, 1, np.array([-1, -1,  1])), # + alpha |101> - beta  |111>; rotate by angle pi around z-axis
                        (-1, -1, 0, np.array([ 1,  1,  1])), # - alpha |110> - beta  |111>; use Bloch vector as-is
                        (-1,  1, 1, np.array([-1,  1, -1])), # + beta  |100> - alpha |110>; rotate by angle pi around y-axis
                    ]
                s = strob_map[ent.stroboscope_idx]
                draw_bloch(tuple(player_pos),       bloch_sphere_sprite, np.array([0, 0, s[0]]))
                draw_bloch(tuple(ent.qpos[  s[2]]), bloch_sphere_sprite, np.array([0, 0, s[1]]))
                draw_bloch(tuple(ent.qpos[1-s[2]]), bloch_sphere_sprite, s[3]*r)
                is_entangled = True
            else:
                if ent.show:
                    # Bloch vectors pointing in opposite directions
                    clr = (0.880722, 0.611041, 0.142051)
                    draw_bloch(tuple(ent.qpos[0]), bloch_sphere_sprite,  ent.bloch_vec, color=clr)
                    draw_bloch(tuple(ent.qpos[1]), bloch_sphere_sprite, -ent.bloch_vec, color=clr)
                else:
                    draw_bloch(tuple(ent.qpos[0]), bloch_sphere_sprite, None)
                    draw_bloch(tuple(ent.qpos[1]), bloch_sphere_sprite, None)

    if not is_entangled:
        # Bloch vector
        r = spherical_to_cartesian(qubit_theta, qubit_phi)
        draw_bloch(tuple(player_pos), bloch_sphere_sprite, r)

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

    global qubit_theta, qubit_theta_dir, qubit_phi

    qubit_theta += np.pi * 0.04*np.sqrt(2) * qubit_theta_dir * dt
    if qubit_theta < 0:
        qubit_theta = -qubit_theta
        qubit_phi += np.pi
        qubit_theta_dir = -qubit_theta_dir
    elif qubit_theta > np.pi:
        qubit_theta = 2*np.pi - qubit_theta
        qubit_phi += np.pi
        qubit_theta_dir = -qubit_theta_dir

    qubit_phi += 2*np.pi * 0.8 * dt
    # avoid eventual overflow
    if qubit_phi > 2*np.pi:
        qubit_phi -= 2*np.pi

    global flash_active, flash_time, flash_duration
    if flash_active:
        flash_time += dt
        if flash_time > flash_duration:
            flash_active = False
            flash_time = 0

    global player_pos
    global player_vel

    # superimpose keyboard movement
    dpos_key = np.zeros(2)
    if   keys[key.LEFT]:  dpos_key[0] -= 150*dt
    elif keys[key.RIGHT]: dpos_key[0] += 150*dt
    elif keys[key.UP]:    dpos_key[1] += 150*dt
    elif keys[key.DOWN]:  dpos_key[1] -= 150*dt

    physics_update(player_pos, player_vel, dt, delta_pos=dpos_key, gammafrict=5)

    global button_aabbs, button_pressed
    global door_open
    button_pressed_prev = button_pressed
    button_pressed = len(button_aabbs) * [False]
    # player bounding box
    size = 0.7*tile_size
    player_box = AABB(player_pos[0] - 0.5*size, player_pos[0] + 0.5*size,
                      player_pos[1] - 0.5*size, player_pos[1] + 0.5*size)
    for i in range(len(button_pressed)):
        if player_box.intersect(button_aabbs[i]):
            button_pressed[i] = True

    # activate door
    door_open[0] = button_pressed[0]

    if button_pressed[0] != button_pressed_prev[0]:
        # restart animation
        door_open_sprites[0]  = pyglet.sprite.Sprite(door_l_open_anim,   door_open_sprites[0].x,  door_open_sprites[0].y)
        door_close_sprites[0] = pyglet.sprite.Sprite(door_l_close_anim, door_close_sprites[0].x, door_close_sprites[0].y)

    global entanglers

    # check if player just activated the entangler
    global show_doc_teleport
    if (button_pressed[1] and (not button_pressed_prev[1])) or (button_pressed[2] and (not button_pressed_prev[2])):
        entanglers[0].reset()
        entanglers[0].activate()
        if show_doc_teleport == MessageState.nascent:
            show_doc_teleport = MessageState.display

    global player_entangler
    global player_entangler_qindex
    player_entangler = None
    # "magnetic" attractive force towards entangler qubits
    radius = 31
    for ent in entanglers:
        ent.entangled = False
        if ent.state != EntanglerState.inactive:
            for i in range(2):
                d = ent.qpos[i] - player_pos
                dist = np.linalg.norm(d)
                if dist < 2.5*radius:
                    player_entangler = ent
                    player_entangler_qindex = i
                    ent.entangled = True
                    ent.qvel[i] += np.sign(2*radius - dist) * dt*40*(d/dist)

    for ent in entanglers:
        ent.update(dt)

    global game_over
    if not game_over:
        # check whether game is over based on player position
        target_box = AABB(tile_size, 5*tile_size, 7*tile_size, 10*tile_size)
        game_over = target_box.contains(player_pos[0], player_pos[1])

    global show_goal, show_game_over
    if game_over:
        show_goal = MessageState.hidden
        show_game_over = MessageState.display


def main():
    # update the game 50 times per second
    pyglet.clock.schedule_interval(update, 1 / 50.0)
    pyglet.app.run()


if __name__ == '__main__':
    main()
