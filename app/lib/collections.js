Charts = new orion.collection('charts');
Commitments = new orion.collection('commitments');
Photos = new orion.collection('photos');
Reactions = new orion.collection('reactions');
Teams = new orion.collection('teams', {
  tabular: {
    columns: [
    { data: "name", title: "Name" },
    { data: "purpose", title: "Purpose" },
    { data: "createdBy", title: "Created by" }
    ]
  }
});
Topics = new orion.collection('topics');
Topics.attachSchema(new SimpleSchema({
  name: {
    type: String,
    label: "Name"
  }
}));
Votes = new orion.collection('votes');
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
Likes = new orion.collection('likes');
