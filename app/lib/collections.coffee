@Commitments = new orion.collection("commitments",
  tabular:
    columns: [
      data: "teamId"
      title: "Team Id"
    ,
      data: "userId"
      title: "User Id"
    ,
      data: "authorId"
      title: "Author Id"
    ]
)
Commitments.attachSchema new SimpleSchema(
  teamId:
    type: String
    label: "Team"
    regEx: SimpleSchema.RegEx.Id
  userId:
    type: String
    label: "User"
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
@Photos = new orion.collection("photos")
@Teams = new orion.collection("teams",
  tabular:
    columns: [
      data: "_id"
      title: "Team Id"
    ,
      data: "name"
      title: "Team Name"
    ,
      data: "purpose"
      title: "Purpose"
    ,
      data: "playfieldId"
      title: "Playfield Id"
    ,
      data: "authorId"
      title: "Author Id"
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
@Keywords = new orion.collection('keywords',
  tabular:
    columns: [
      data: "_id"
      title: "Keyword Id"
    ,
      data: "name"
      title: "Keyword Name"
    ,
      data: "authorId"
      title: "Author Id"
    ]
)
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
@TeamKeywords = new orion.collection('team_keywords',
  tabular:
    columns: [
      data: "teamId"
      title: "Team Id"
    ,
      data: "keywordId"
      title: "Keyword Id"
    ,
      data: "authorId"
      title: "Author Id"
     ]
)
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
@UserKeywords = new orion.collection('user_keywords',
  tabular:
    columns: [
      data: "userId"
      title: "User Id"
    ,
      data: "keywordId"
      title: "Keyword Id"
    ,
      data: "authorId"
      title: "Author Id"
     ]
)
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
      data: "_id"
      title: "Playfield Id"
    ,
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
      title: "Author Id"
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
      title: "Team Id"
    ,
      data: "playfieldId"
      title: "Playfield Id"
    ,
      data: "created"
      title: "Created"
    ,
      data: "updated"
      title: "Updated"
    ,
      data: "authorId"
      title: "Author Id"
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
