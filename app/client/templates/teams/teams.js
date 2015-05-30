/*****************************************************************************/
/* Teams: Event Handlers */
/*****************************************************************************/
Template.Teams.events({
  "submit #new-team-form": function(event, template) {
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

Template.Players.helpers({
  players: function () {
    var commitments = Commitments.find({teamId: this._id}).fetch();
    var userIds = _.pluck(commitments, "userId");
    var players = Meteor.users.find({_id: {$in: userIds}});
    return players;
  }
});

Template.Team.events({
  "click .join": function(event, template) {
    Commitments.insert({teamId: this._id, userId: Meteor.userId()});
  },
  "click .leave": function(event, template) {
    var commitment = Commitments.findOne({teamId: this._id, userId: Meteor.userId()});
    Commitments.remove({_id: commitment._id});
    var wasntLastPlayer = Commitments.findOne({teamId: this._id});
    if (!wasntLastPlayer) {
      Teams.remove({_id: this._id});
    }
  }
});

Template.Team.helpers({
  participating: function () {
    if (Commitments.findOne({teamId: this._id, userId: Meteor.userId()})) {
      return true;
    } else {
      return false;
    }
  }
});

Template.Player.events({
  "submit #reaction-form": function (event, template) {
    event.preventDefault();
    var userId = template.data._id;
    var teamId = Template.parentData(1)._id;
    var feedback = event.target.feedback;
    if (feedback.value) {
      console.log(feedback.value);
      var existingReaction = Reactions.findOne({userId: userId, teamId: teamId, evaluator: Meteor.userId()});
      if (existingReaction) {
        console.log("existing: ", existingReaction);
        Reactions.update({_id: existingReaction._id}, {$set: {feedback: feedback.value}});
      } else {
        Reactions.insert({userId: userId, teamId: teamId, evaluator: Meteor.userId(), feedback: feedback.value});
      }
    }
    Session.set("target" + userId + teamId, false);
  },
  "click .cancel": function () {
    var userId = template.data._id;
    var teamId = Template.parentData(1)._id;
    Session.set("target" + userId + teamId, false);
  },
  "click #edit": function (event, template) {
    var userId = template.data._id;
    var teamId = Template.parentData(1)._id;
    Session.set("target" + userId + teamId, true);
  },
  "keypress input": function (event, template) {
    if (event.keyCode == 13) {
      var reaction = Reactions.findOne({});
      Reactions.update({_id: reaction._id}, {$set: {feedback: event.currentTarget.value}});
      var userId = template.data._id;
      var teamId = Template.parentData(1)._id;
      Session.set("target" + userId + teamId, false);
    }
  },
  "click #delete": function (event, template) {
    var reaction = Reactons.findOne({userId: template.data._id, teamId: Template.parentData(1)._id});
    Reactions.remove({_id: reaction._id});
  }
});

Template.Player.helpers({
  reacting: function () {
    Session.set('reacting', true);
  },
  editing: function () {
    return Session.get("target" + this._id + Template.parentData(1)._id);
  },
  feedback: function () {
    var userId = this._id;
    var teamId = Template.parentData(1)._id;
    var reaction = Reactions.findOne({userId: userId, teamId: teamId, evaluator: Meteor.userId()});
    if (reaction) {
      return reaction.feedback;
    }
    return null;
  }
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