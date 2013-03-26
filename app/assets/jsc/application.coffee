$(document).ready ->
  $("#user aside h2").fitText 1.1

  $(".description h4 a.expand").on "click", ->
    if $(".description .text").hasClass("hidden")
      $(".description .text").removeClass("hidden").addClass("display")
    else
      $(".description .text").removeClass("display").addClass "hidden"

  $('input.tags').tagsManager
    hiddenTagListName: 'note[tags]'

  arr = $('input[name="existing-tags"]').attr('value')

  if arr
    arr = arr.split(",")
    for i of arr
      $('input.tags').tagsManager('pushTag', arr[i])

  $("input.tags").autoGrowInput
    comfortZone: 20
    minWidth: 200
    maxWidth: 900

  $(".textbox footer").click ->
    $(".textbox footer input").focus()


  tags = []

  # If tag in note is clicked
  $("footer ul.tags li a").on 'click', ->
    # Unless the tag is already in the array
    unless tags.indexOf($(this).text()) != -1
      # Add it to the array
      tags.push($(this).text())

      # Put it in the header
      $("header ul.tags").append '<li data-value="' + $(this).text() + '"><span class="btn">' + $(this).text() + ' <a href="#"><i class="ss-icon">close</i></a></span></li>'

    console.log tags

  # If tag in header is clicked
  $("header ul.tags").on 'click', 'li span', ->
    tag = $(this).parent().attr("data-value")

    # Remove from array
    tags = _.without tags, tag

    # Remove from header list
    $(this).parent().parent().remove()

