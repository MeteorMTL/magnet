/*****************************************************************************/
/* People: Event Handlers */
/*****************************************************************************/
Template.People.events({
});

/*****************************************************************************/
/* People: Helpers */
/*****************************************************************************/
Template.People.helpers({
  people: function () {
    return Meteor.users.find({}, {sort: {lastAnnounced: -1}, limit: 100});
  }
});

/*****************************************************************************/
/* People: Lifecycle Hooks */
/*****************************************************************************/
Template.People.created = function () {
};

Template.People.rendered = function () {
};

Template.People.destroyed = function () {
};
