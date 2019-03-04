class BinaryTreeView
  drawCanvas: ->
    $.getScript("/my_networks/#{@parentId}.js")
  constructor: (@parentId) ->
  render: ->
    @drawCanvas(@parentId)


$(document).on "turbolinks:load", ->
  $(document).on 'click', '.node-focus-href', (eventObject) ->
    eventObject.preventDefault()
    window.treeNodeCount = 0
    childName = $(@).data("child-name")
    childId = $(@).data("child-id")
    html = "<ul><li id='tree_user_#{childId}' data-node-name='#{childName}' data-node-id='#{childId}'>"
    html += "<a href='#' class='node-focus-href' data-child-id='#{childId}'>#{childName}</a>"
    html += "</li></ul>"
    treeBackState.push($('.tree').html())
    $('.tree').html(html)
    binaryTree = new BinaryTreeView(childId)
    binaryTree.render()
    if treeBackState.length
      $("#back_genealogy_btn").html("<a href='#' class='back-btn-tree'>Back</a>")

  $(document).on "click", ".back-btn-tree", (eventObject) ->
    eventObject.preventDefault()
    html = treeBackState.pop()
    $('.tree').html(html)
    if treeBackState.length
      $("#back_genealogy_btn").html("<a href='#' class='back-btn-tree'>Back</a>")
    else
      $("#back_genealogy_btn").html("")
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
    window.treeNodeCount = 0
    window.treeBackState = new Array()
    window.btView = new BinaryTreeView(currentUserId)
    btView.render()
