class BinaryTreeView
  drawCanvas: ->
    $.getScript("/my_networks/#{@parentId}.js")
  constructor: (@parentId) ->
  render: ->
    @drawCanvas(@parentId)


$(document).on "turbolinks:load", ->
  $(document).on "click", ".later-payment-prompt", (eventObject) ->
    eventObject.preventDefault()
    alert("Coming soon")
  $(document).on "click", ".new-child-href", (eventObject) ->
    $parentLi = $(@).parent("li")
    parentId = $parentLi.data("parent-id")
    position = $parentLi.data("position")
    $.post("/my_networks.js", {
      user: {
        parent_id: parentId,
        parent_position: position
      }
    })
  canvasContainer = $("[data-load-default-tree]")
  if canvasContainer.length
    window.btView = new BinaryTreeView(currentUserId)
    btView.render()
