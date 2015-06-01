/*****************************************************************************/
/* Topics: Event Handlers */
/*****************************************************************************/
Template.Topics.events({
  "submit form": function (event, template) {
    event.preventDefault();
    var input = event.target.name;
    var topicId = Topics.insert({name: input.value, totalPoints: 0});
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
    input.value = '';
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
  availablePoints: getAvailablePoints
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
