/*****************************************************************************/
/* Team: Event Handlers */
/*****************************************************************************/
Template.Team.events({
  "click .changeOwner": function (event, template) {
	  _changeOwner(this._id);
  },
 "submit #addPlayersForm": function (event, template) {
   event.preventDefault();
   var newPlayer = event.target.selectPlayer.value;
   if (!Commitments.findOne({teamId: this._id, userId: newPlayer})) {
      Commitments.insert({teamId: this._id, userId: newPlayer});
   } else { alert ("already exists"); }
  },
"submit #addPlayersKeywordsForm": function (event, template) {
	event.preventDefault();
	var newTeamTopic = event.target.selectPlayerKeywords.value;
	if (!TeamTopics.findOne({teamId: this._id, authorId: Meteor.userId(), name: newTeamTopic})) {
		TeamTopics.insert({teamId: this._id, authorId: Meteor.userId(), name: newTeamTopic});
	} else { alert ("already exists"); }
},
 "submit #new-keyword": function (event, template) {
   event.preventDefault();
   var newTeamTopic = event.target.name.value;
   console.log(newTeamTopic);
   if (newTeamTopic.length === 0) {
     alert("can't be blank");
     return;
   }
   if (!TeamTopics.findOne({teamId: this._id, authorId: Meteor.userId(), name: newTeamTopic})) {
      TeamTopics.insert({teamId: this._id, authorId: Meteor.userId(), name: newTeamTopic});
      event.target.name.value="";
   } else { alert ("you are not on the team"); }
  },
 "submit #changeOwnerForm": function (event, template) {
   event.preventDefault();
   var newOwner = event.target.select.value;
   if (Commitments.findOne({teamId: this._id, userId: Meteor.userId()})) {
      Teams.update({_id: this._id}, {$set: {createdBy: newOwner}});
   } else { alert ("you are not on the team"); }
  },
  "click .join": function (event, template) {
   if (!Commitments.findOne({teamId: this._id, userId: Meteor.userId()}))
    Commitments.insert({teamId: this._id, userId: Meteor.userId()});
   else alert ("you are already on the team");
  },
  "click .leave": function (event, template) {
    if (_players(this._id).length > 1 && Meteor.userId() === this.createdBy) _changeOwner(this._id);
    var commitment = Commitments.findOne({teamId: this._id, userId: Meteor.userId()});
    Commitments.remove({_id: commitment._id});
    if (!Commitments.findOne({teamId: this._id})) Teams.remove({_id: this._id});
  }
});

/*****************************************************************************/
/* Team: Helpers */
/*****************************************************************************/
// a little helper function helpers
_players = function(teamId) {
	// get all the players on the team
	commitments = Commitments.find({teamId: teamId}).fetch();
	//console.log(commitments);
	userIds = _.pluck(commitments, "userId");
	// remove current player
	userIds = _.reject(userIds,function(id){ return id  === Meteor.userId(); });
	players = Meteor.users.find({_id: {$in: userIds}}).fetch();
	//console.log(players);
	return players;    
}

_changeOwner = function(teamId) {
	var players = _players(teamId);
	// choose first player from team
	var newOwner = players[0]._id;
	if (Commitments.findOne({teamId: teamId, userId: Meteor.userId()})) {
		Teams.update({_id: teamId}, {$set: {createdBy: newOwner}});
	} else { alert ("you are not on the team"); }
}


_creator = function (createdBy) {
	//console.log(Meteor.userId());
	//console.log(this.createdBy);
	return Meteor.userId() === createdBy ? "organizer":"";
}
// little helper function helpers

Template.Team.helpers({
  participating: function () {
    //alert("teamID " + this._id);
    if (Commitments.findOne({teamId: this._id, userId: Meteor.userId()})) {
      return true;
    } else {
      return false;
    }
  },
  creator: function () {
    return _creator(this.createdBy);
  },
  playersNotOnTeam: function() {
	  commitments = Commitments.find({teamId: this._id}).fetch();
	  userIds = _.pluck(commitments, "userId");
	  players = Meteor.users.find({_id: {$nin: userIds}}).fetch();
	  return players;    
  },
  players: function() {
	  return _players(this._id);
  },
  playersLengthGreaterThanOne : function() {
	  return _players(this._id).length > 1;    
  },
  playersLengthEqualsOne: function() {
	  return _players(this._id).length === 1;    
  },
  latestMessage: function () {
    var teamId = this._id;
    var messages = Messages.find({teamId: teamId}, {sort: {createdAt: -1}}).fetch();
    if (messages.length) {
      return messages[0].message;
    }
    return '';
  },
  teamTopics: function () {
    console.log("team topics");
    //return TeamTopics.find({});
    return TeamTopics.find({teamId: this._id});
  },
  topics: function () {
    var teamId = this._id;
    var commitments = Commitments.find({teamId: teamId}).fetch();
    var userIds = _.pluck(commitments, "userId");
    var topicIds = _.pluck(Votes.find({userId: {$in: userIds}}, {sort: {points: -1}}).fetch(), 'topicId');
    return Topics.find({_id: {$in: topicIds}});
  }
});

/*****************************************************************************/
/* Team: Lifecycle Hooks */
/*****************************************************************************/
Template.Team.created = function () {
};

Template.Team.rendered = function () {
};

Template.Team.destroyed = function () {
};
