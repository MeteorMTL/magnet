/*****************************************************************************/
/* Topics: Event Handlers */
/*****************************************************************************/
Template.Topics.events({
  "submit form": function (event, template) {
    event.preventDefault();
    var input = event.target.name;
    Topics.insert({name: input.value, totalPoints: 0});
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
