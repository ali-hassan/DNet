
Node = (x, y, r, ctx, data) ->
  # left child of a node
  @leftNode = null
  # right child of a node
  @rightNode = null
  # draw function. Responsible for drawing the node

  @draw = ->
    ctx.beginPath()
    ctx.arc x, y, r, 0, 2 * Math.PI
    ctx.stroke()
    ctx.closePath()
    ctx.strokeText data, x, y
    return

  # Simple getters

  @getData = ->
    data

  @getX = ->
    x

  @getY = ->
    y

  @getRadius = ->
    r

  # Returns coordinate for the left child
  # Go back 3 times radius in x axis and 
  # go down 3 times radius in y axis

  @leftCoordinate = ->
    {
      cx: x - (3 * r)
      cy: y + 3 * r
    }

  # Same concept as above but for right child        

  @rightCoordinate = ->
    {
      cx: x + 3 * r
      cy: y + 3 * r
    }

  return

# Draws a line from one circle(node) to another circle (node) 

Line = ->
  # Takes 
  # x,y      - starting x,y coordinate
  # toX, toY - ending x,y coordinate

  @draw = (x, y, toX, toY, r, ctx) ->
    moveToX = x
    moveToY = y + r
    lineToX = toX
    lineToY = toY - r
    ctx.beginPath()
    ctx.moveTo moveToX, moveToY
    ctx.lineTo lineToX, lineToY
    ctx.stroke()
    return

  return

# Represents the btree logic

BTree = ->
  c = document.getElementById('my_network_view')
  ctx = c.getContext('2d')
  line = new Line
  @root = null
  self = this
  # Getter for root

  @getRoot = ->
    @root

  # Adds element to the tree

  @add = (data) ->
    # If root exists, then recursively find the place to add the new node
    if @root
      @recursiveAddNode @root, null, null, data
    else
      # If not, the add the element as a root 
      @root = @addAndDisplayNode(200, 20, 15, ctx, data)
      return
    return

  # Recurively traverse the tree and find the place to add the node

  @recursiveAddNode = (node, prevNode, coordinateCallback, data) ->
    if !node
      # This is either node.leftCoordinate or node.rightCoordinate
      xy = coordinateCallback()
      newNode = @addAndDisplayNode(xy.cx, xy.cy, 15, ctx, data)
      line.draw prevNode.getX(), prevNode.getY(), xy.cx, xy.cy, prevNode.getRadius(), ctx
      newNode
    else
      if data <= node.getData()
        node.left = @recursiveAddNode(node.left, node, node.leftCoordinate, data)
      else
        node.right = @recursiveAddNode(node.right, node, node.rightCoordinate, data)
      node

  # Adds the node to the tree and calls the draw function

  @addAndDisplayNode = (x, y, r, ctx, data) ->
    node = new Node(x, y, r, ctx, data)
    node.draw()
    node

  return

addToTree = ->
  input = document.getElementById('tree-input')
  value = parseInt(input.value)
  if value
    btree.add value
  else
    alert 'Wrong input'
  return

class BinaryTreeView
  drawCanvas: ->
    @btree.add(@parentId)
  constructor: (@parentId) ->
    @btree = new BTree
  render: ->
    @drawCanvas(@parentId)


$(document).on "turbolinks:load", ->
  canvasContainer = $("#my_network_view");
  if canvasContainer.length
    window.btView = new BinaryTreeView(currentUserId)
    btView.render()
