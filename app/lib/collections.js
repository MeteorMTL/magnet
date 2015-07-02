Charts = new Mongo.Collection('charts');
Commitments = new Mongo.Collection('commitments');
Photos = new Mongo.Collection('photos');
Reactions = new Mongo.Collection('reactions');
Teams = new orion.collection('teams', {
  tabular: {
    columns: [
    { data: "name", title: "Name" },
    { data: "purpose", title: "Purpose" },
    { data: "createdBy", title: "Created by" }
    ]
  }
});
Topics = new Mongo.Collection('topics');
Votes = new Mongo.Collection('votes');
Messages = new orion.collection('messages', {
  tabular: {
    columns: [
    { data: "teamId", title: "Team" },
    { data: "createdAt", title: "When" },
    { data: "message", title: "Message" },
    { data: "userId", title: "Who" }
    ]
  }
});
Likes = new Mongo.Collection('likes');
