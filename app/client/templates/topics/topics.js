/*****************************************************************************/
/* Topics: Event Handlers */
/*****************************************************************************/
Template.Topics.events({
  "submit #new-keyword": function (event, template) {
    event.preventDefault();
    var name = event.target.name;
    console.log("value: ", name.value);
    var topicId = Topics.insert({name: name.value, totalPoints: 0, authorId: Meteor.userId()});
    var topic = Topics.findOne({_id: topicId});
    var user = Meteor.user();
    if (user) {
      var vote = Votes.findOne({
        userId: user._id,
        topicId: topic._id
      });
      if (vote) {
        Votes.update({_id: vote._id}, {$inc: {points: 1}});
      } else {
        Votes.insert({userId: user._id, topicId: topic._id, points: 1});
      }
      Topics.update({_id: topic._id}, {$inc: {totalPoints: 1}});
    }
    name.value = '';
  }
});

/*****************************************************************************/
/* Topics: Helpers */
/*****************************************************************************/
Template.Topics.helpers({
  canVote: function () {
    return Meteor.user() && Topics.find().count();
  },
  topics: function () {
    return Topics.find({}, {sort: {totalPoints: -1}});
  },
  availablePoints: getAvailablePoints,
  anyPoints: getAnyPoints,
  usedPoints: getUsedPoints
});

/*****************************************************************************/
/* Topics: Lifecycle Hooks */
/*****************************************************************************/
Template.Topics.created = function () {
};

Template.Topics.rendered = function () {
};

Template.Topics.destroyed = function () {
};
