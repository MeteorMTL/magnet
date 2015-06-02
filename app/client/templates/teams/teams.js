/*****************************************************************************/
/* Teams: Event Handlers */
/*****************************************************************************/
Template.Teams.events({
  "submit #new-team-form": function (event, template) {
    event.preventDefault();
    var name = event.target.name;
    var purpose = event.target.purpose;
    teamId = Teams.insert({name: name.value, purpose: purpose.value, "created": new Date(), createdBy: Meteor.userId()});
    Commitments.insert({teamId: teamId, userId: Meteor.userId()});
    name.value = '';
    purpose.value = '';
  }
});

/*****************************************************************************/
/* Teams: Helpers */
/*****************************************************************************/
Template.Teams.helpers({
});

/*****************************************************************************/
/* Teams: Lifecycle Hooks */
/*****************************************************************************/
Template.Teams.created = function () {
};

Template.Teams.rendered = function () {
};

Template.Teams.destroyed = function () {
};
