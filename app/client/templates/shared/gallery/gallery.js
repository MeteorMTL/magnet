if (Meteor.isClient) {

  Template.carousel.rendered = function() {
    //Create Accordion
    $accordion = $("#accordion").accordion({"path":"accordion/"});
    //Autoplay
    //$('#play').click();
  };

}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}
