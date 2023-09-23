import pygame
import sys
import random
import time
pygame.init()
 
'''' game variables '''
score_value = 0
FPS = 180
fpsClock = pygame.time.Clock()
press_up = False
press_down = False
press_left = False
press_right = False
player1_w = 15
player1_h = 15
# players attributes
player1_y = 50
player1_x = 50
vel_y = 2
vel_x = 2
# maze attributes
maze_data = [ 1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
              1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,
              1,1,1,1,1,0,1,0,1,1,1,1,1,1,1,0,1,
              1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,1,
              1,0,1,1,1,1,1,1,1,0,1,1,1,0,1,1,1,
              1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,
              1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0,1,
              1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,
              1,1,1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,
              1,0,1,0,1,0,0,0,1,0,0,0,0,0,0,0,1,
              1,0,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,
              1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,
              1,0,0,0,1,1,1,1,1,1,1,0,1,1,1,1,1,
              1,1,1,1,1,0,0,0,0,0,1,0,1,0,1,0,1,
              1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,
              1,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,
              1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,
            ]

tile_columns = 17
tile_rows = 18
tile_size = 39
score_showing = False
font = pygame.font.Font('Big Pixel Shadow demo.otf',32) 

''' game objects '''
# Create the screen object
SCREEN_WIDTH = tile_size * tile_columns # 663
SCREEN_HEIGHT = tile_size * tile_rows # 702
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
# player
player1_rect = pygame.Rect(player1_x, player1_y,
                           player1_w, player1_h)
running = True


# image = pygame.image.load("slime.gif")
# screen = screen.blit(image,(100,100))

  
'''game  functions'''
class World():
  def __init__(self, data):
    global maze_data, tile_columns, tile_rows, tile_size
    self.tile_list = []
    for row in range(tile_rows): # height - change later
      for column in range(tile_columns): # width - change later
        square = row * tile_columns + column # width - change later
        if maze_data[square] == int(1):
          tile = pygame.Rect(column * tile_size, row * tile_size, tile_size, tile_size)
          pygame.draw.rect(screen, (136, 17, 92), tile)
          self.tile_list.append(tile)


'''main code'''
while running:
    screen.fill((239, 193, 222))
    # world drawing???
    world = World(maze_data)
    for ind_tile in world.tile_list:
      if player1_rect.colliderect(ind_tile):
        # x values
        if player1_rect.left < ind_tile.right and player1_rect.left > ind_tile.left and press_left:
          player1_rect.left = ind_tile.right 
        if player1_rect.right > ind_tile.left and player1_rect.right < ind_tile.right and press_right:
          player1_rect.right = ind_tile.left 
        # y values
        if player1_rect.top < ind_tile.bottom and player1_rect.top > ind_tile.top and press_up:
          player1_rect.top = ind_tile.bottom 
        if player1_rect.bottom > ind_tile.top and player1_rect.bottom < ind_tile.bottom and press_down:
          player1_rect.bottom = ind_tile.top 
    # storing current position
    player1_y = player1_rect.top + (player1_h / 2) 
    player1_x = player1_rect.left + (player1_w / 2)
    # checking what is/isn't pressed
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_UP:
                press_up = True
                press_down = False
                press_right = False
                press_left = False
            if event.key == pygame.K_DOWN:
                press_up = False
                press_down = True
                press_right = False
                press_left = False
            if event.key == pygame.K_RIGHT:
                press_up = False
                press_down = False
                press_right = True
                press_left = False
            if event.key == pygame.K_LEFT:                
                press_up = False
                press_left = True
                press_down = False
                press_right = False
        elif event.type == pygame.KEYUP:
            if event.key == pygame.K_UP:
                press_up = False
            if event.key == pygame.K_DOWN:
                press_down = False
            if event.key == pygame.K_LEFT:
                press_left = False
            if event.key == pygame.K_RIGHT:
                press_right = False
    # if smthn's pressed, move it
    if score_showing == False:
      if press_down:
          player1_rect.move_ip(0, vel_y)
      if press_up:
          player1_rect.move_ip(0, -vel_y)
      if press_right:
          player1_rect.move_ip(vel_x, 0)
      if press_left:
          player1_rect.move_ip(-vel_x, 0)
   
    #draw and udpate
    pygame.draw.rect(screen, (174, 50, 179), player1_rect)
    if player1_rect.bottom > SCREEN_HEIGHT:
      pygame.draw.rect(screen, "white", (0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
      screen.blit(font.render("* u win yay *", True, (0,0,0)), (190, 280))
      screen.blit(font.render("have a cookie :)", True, (0,0,0)), (160, 315))
      image = pygame.image.load('cookie image (1).png')
      screen.blit(image, (50, 50))
      screen.blit(image, (463, 502))
      score_showing = True
    pygame.display.update()
    fpsClock.tick(FPS)

pygame.quit()
