@Commitments = new orion.collection("commitments")
@Photos = new orion.collection("photos")
@Teams = new orion.collection("teams",
  tabular:
    columns: [
      data: "name"
      title: "Name"
    ,
      data: "purpose"
      title: "Purpose"
    ,
      data: "playfieldId"
      title: "Playfield"
    ,
      data: "authorId"
      title: "Author"
    ]
)
Teams.attachSchema new SimpleSchema(
  name:
    type: String
    label: "Team Name"
  purpose:
    type: String
    label: "Team Purpose"
  playfieldId:
    type: String
    label: "Playfield"
    regEx: SimpleSchema.RegEx.Id
    autoform:
      type: "select"
      options: ->
        _.map Playfields.find().fetch(), (playfield) ->
          {
            label: playfield.name
            value: playfield._id
          }
  created:
    type: Date
    label: "Created At"
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  updated:
    type: Date
    label: "Updated At"
    autoValue: ->
      new Date()
  authorId:
    type: String
    label: "Author"
    regEx: SimpleSchema.RegEx.Id
)
Teams.after.insert((userId, doc) ->
  Commitments.insert
    teamId: doc._id
    userId: userId
)
@Keywords = new orion.collection('keywords')
Keywords.attachSchema new SimpleSchema(
  name:
    type: String
    label: "Keyword Name"
    index: true
    unique: true
  created:
    type: Date
    label: "Created At"
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  updated:
    type: Date
    label: "Updated At"
    autoValue: ->
      new Date()
  authorId:
    type: String
    regEx: SimpleSchema.RegEx.Id
)
@Messages = new orion.collection("messages",
  tabular:
    columns: [
      data: "teamId"
      title: "Team"
    ,
      data: "createdAt"
      title: "When"
    ,
      data: "message"
      title: "Message"
    ,
      data: "userId"
      title: "Who"
     ]
)
@TeamKeywords = new orion.collection('team_keywords')
TeamKeywords.attachSchema new SimpleSchema(
  teamId:
    type: String
    label: "Team"
    regEx: SimpleSchema.RegEx.Id
  keywordId:
    type: String
    label: "Keyword"
    regEx: SimpleSchema.RegEx.Id
  created:
    type: Date
    label: "Created At"
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  updated:
    type: Date
    label: "Updated At"
    autoValue: ->
      new Date()
  authorId:
    type: String
    label: "Author"
    regEx: SimpleSchema.RegEx.Id
)
@UserKeywords = new orion.collection('user_keywords')
UserKeywords.attachSchema new SimpleSchema(
  userId:
    type: String
    label: "User"
    regEx: SimpleSchema.RegEx.Id
  keywordId:
    type: String
    label: "Keyword"
    regEx: SimpleSchema.RegEx.Id
  created:
    type: Date
    label: "Created At"
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  updated:
    type: Date
    label: "Updated At"
    autoValue: ->
      new Date()
  authorId:
    type: String
    label: "Author"
    regEx: SimpleSchema.RegEx.Id
)
@Playfields = new orion.collection('playfields',
  tabular:
    columns: [
      data: "name"
      title: "Playfield Name"
    ,
      data: "created"
      title: "Created"
    ,
      data: "updated"
      title: "Updated"
    ,
      data: "authorId"
      title: "Author"
    ]
)
Playfields.attachSchema new SimpleSchema(
  name:
    type: String
    label: "Playfield Name"
  created:
    type: Date
    label: "Created At"
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  updated:
    type: Date
    label: "Updated At"
    autoValue: ->
      new Date()
  authorId:
    type: String
    regEx: SimpleSchema.RegEx.Id
)
@TeamPlayfields = new orion.collection('team_playfields',
  tabular:
    columns: [
      data: "teamId"
      title: "Team"
    ,
      data: "playfieldId"
      title: "Playfield"
    ,
      data: "created"
      title: "Created"
    ,
      data: "updated"
      title: "Updated"
    ,
      data: "authorId"
      title: "Author"
    ]
)
TeamPlayfields.attachSchema new SimpleSchema(
  teamId:
    type: String
    label: "Team"
    regEx: SimpleSchema.RegEx.Id
  playfieldId:
    type: String
    label: "Playfield"
    regEx: SimpleSchema.RegEx.Id
  created:
    type: Date
    label: "Created At"
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  updated:
    type: Date
    label: "Updated At"
    autoValue: ->
      new Date()
  authorId:
    type: String
    label: "Author"
    regEx: SimpleSchema.RegEx.Id
)
