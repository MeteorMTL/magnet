Template.Teams.events {
  'change select[name=playfieldId]': (event, template) ->
    event.preventDefault()
    $("form#activePlayfield").submit()
}

Template.Teams.helpers {
  teams: ->
    Teams.find(
      playfieldId: Session.get("activePlayfield")
    ,
      sort:
        updated: -1
    )
  activePlayfieldSchema: ->
    schemas.activePlayfield
  activePlayfieldDoc: ->
    {
      playfieldId: Session.get("activePlayfield")
    }
}

Template.Teams.created = ->

Template.Teams.rendered = ->

Template.Teams.destroyed = ->
