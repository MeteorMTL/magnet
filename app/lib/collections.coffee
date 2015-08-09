@Charts = new orion.collection("charts")
@Commitments = new orion.collection("commitments")
@Photos = new orion.collection("photos")
@Reactions = new orion.collection("reactions")
@Teams = new orion.collection("teams",
  tabular:
    columns: [
      data: "name"
      title: "Name"
    ,
      data: "purpose"
      title: "Purpose"
    ,
      data: "createdBy"
      title: "Created by"
     ]
)
@TeamTopics = new orion.collection("teamTopics")
TeamTopics.attachSchema new SimpleSchema(
  name:
    type: String
    label: "Name"
  totalPoints:
    type: Number
    label: "Total Points"
    optional: true
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
  teamId:
    type: String
    regEx: SimpleSchema.RegEx.Id
  authorId:
    type: String
    regEx: SimpleSchema.RegEx.Id
)
@Keywords = new orion.collection('keywords')
Keywords.attachSchema new SimpleSchema(
  name:
    type: String
    label: "Keyword Name"
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
@Topics = new orion.collection("topics")
Topics.attachSchema new SimpleSchema(
  name:
    type: String
    label: "Name"
  totalPoints:
    type: Number
    label: "Total Points"
    optional: true
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
@Votes = new orion.collection("votes")
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
@Likes = new orion.collection("likes")
