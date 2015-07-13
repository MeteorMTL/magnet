/*****************************************************************************/
/* Footer: Event Handlers */
/*****************************************************************************/
Template.Footer.events({
'click #about': function(e, t) {
  msg0="Live social teaming for in-person events: http://speedteam.ca. Find team mates, do micro-projects";
  AntiModals.alert({title: "About", message: msg0});
},
'click #theTeam': function(e, t) {
  //AntiModals.alert({title: "the Team", message: Template.carousel.render()});
  msg = '' +
'  <div id="acc-wrap">' +
'    <div id="accordion">' +
'      <div id="accdiv">' +
'        <ul id="accul">' +
'          <li class="accli">' +
'              <div class="imgdiv"><div class="imgwrap"><img src="accordion/01.jpg" alt=""></div></div>' +
'              <div class="short"><p><span>David Rowan</span></p></div>' +
'              <div class="text bottom-right">' +
'                <p><span>Co-founder, COO</span></p>' +
'              </div>' +
'            </a>' +
'          </li>' +
'' +
'          <li class="accli">' +
'              <div class="imgdiv"><div class="imgwrap"><img src="accordion/02.jpg" alt=""></div></div>' +
'              <div class="short"><p><span>Paul Cuciureanu</span></p></div>' +
'              <div class="text bottom-right">' +
'                <p><span>Co-founder, CPO</span></p>' +
'              </div>' +
'            </a>' +
'          </li>' +
'' +
'          <li class="accli">' +
'            <a>' +
'              <div class="imgdiv"><div class="imgwrap"><img src="accordion/03.jpg" alt=""></div></div>' +
'              <div class="short"><p><span>David Rowan</span></p></div>' +
'              <div class="text bottom-right">' +
'                <p class=""><span>Co-founder, COO</span></p>' +
'              </div>' +
'            </a>' +
'          </li>' +
'' +
'          <li class="accli">' +
'            <a>' +
'              <div class="imgdiv"><div class="imgwrap"><img src="accordion/04.jpg" alt=""></div></div>' +
'              <div class="short"><p><span>Paul Cuciureanu</span></p></div>' +
'              <div class="text bottom-right">' +
'                <p class=""><span>Co-founder, CPO</span></p>' +
'              </div>' +
'            </a>' +
'          </li>' +
'' +
'          <li class="accli">' +
'            <a>' +
'              <div class="imgdiv"><div class="imgwrap"><img src="accordion/05.jpg" alt=""></div></div>' +
'              <div class="short"><p><span>David Rowan</span></p></div>' +
'              <div class="text bottom-right">' +
'                <p class=""><span>Co-founder, COO</span></p>' +
'              </div>' +
'            </a>' +
'          </li>' +
'' +
'          <li class="accli">' +
'            <a>' +
'              <div class="imgdiv"><div class="imgwrap"><img src="accordion/06.jpg" alt=""></div></div>' +
'              <div class="short"><p><span>Paul Cuciureanu</span></p></div>' +
'              <div class="text bottom-right">' +
'                <p><span>Co-founder, CPO</span></p>' +
'              </div>' +
'            </a>' +
'          </li>' +
'        </ul>' +
'      </div>' +
'      <!--      <div class="Controller"></div> -->' +
'    </div>' +
'  </div>' +
'';
  AntiModals.alert({title: "the Team", message: msg, width: "1200px;"});
}
});

/*****************************************************************************/
/* Footer: Helpers */
/*****************************************************************************/
Template.Footer.helpers({
});

/*****************************************************************************/
/* Footer: Lifecycle Hooks */
/*****************************************************************************/
Template.Footer.created = function () {
};

Template.Footer.rendered = function () {
};

Template.Footer.destroyed = function () {
};
