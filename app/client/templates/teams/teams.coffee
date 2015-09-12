Template.Teams.events {
  'change #activePlayfield .af-radio-group': (event, template) ->
    event.preventDefault()
    $("form#activePlayfield").submit()
}

Template.Teams.helpers {
  activePlayfieldSchema: ->
    schemas.activePlayfield
}

Template.Teams.created = ->

Template.Teams.rendered = ->

Template.Teams.destroyed = ->
