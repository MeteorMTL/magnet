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
}
