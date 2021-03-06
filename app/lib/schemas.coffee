@schemas = {
  activePlayfield: new SimpleSchema(
    playfieldId:
      type: String
      label: "Activate Playfield"
      autoform:
        type: "select"
        options: ->
          _.map Playfields.find().fetch(), (playfield) ->
            {
              label: playfield.name
              value: playfield._id
            }
  )
  keyword: new SimpleSchema(
    name:
      type: String
      label: "New Keyword"
  )
  teamKeyword: new SimpleSchema(
    name:
      type: String
      label: "New Team Keyword"
    teamId:
      type: String
      label: "Team"
      regEx: SimpleSchema.RegEx.Id
      autoform:
        type: "hidden"
  )
}
