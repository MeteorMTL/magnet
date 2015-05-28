/*****************************************************************************/
/* TopicShow: Event Handlers */
/*****************************************************************************/
Template.TopicShow.events({
  "click .edit": function () {
    Router.go('TopicEdit', {_id: Router.current().params._id});
  },
  "click .delete": function () {
    Router.go('Home');
  }
});

/*****************************************************************************/
/* TopicShow: Helpers */
/*****************************************************************************/
Template.TopicShow.helpers({
  voters: function () {
    console.log(this)
    var topicVotes = Votes.find({_id: this.params._id})
    console.log(topicVotes)
    return Meteor.users.find({}, {sort: {lastAnnounced: -1}});
  }
});

/*****************************************************************************/
/* TopicShow: Lifecycle Hooks */
/*****************************************************************************/
Template.TopicShow.created = function () {
};

Template.TopicShow.rendered = function () {
};

Template.TopicShow.destroyed = function () {
};
