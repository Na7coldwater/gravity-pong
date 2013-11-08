// Some fixes to fix some Processing.js
// differences that were breaking my sketch
window.onload=function(){
  tryFindSketch(fixThings);  
}

function fixThings(pjs)
{
  // Fix the ArrayList bug
  // Processing.js initalizes an ArrayList's length
  // to the value given in the constructor, 
  // which is incorrect behavior.
  // So we replace the constructor with a version that ignores
  // the argument
  var oldArrayList = pjs.ArrayList;
  pjs.ArrayList = function() {
    return new oldArrayList();
  };
  
  // Provide our own implementation of PVector.rotate()
  // if needed
  if(!pjs.PVector.prototype.rotate)
  {
    pjs.PVector.prototype.rotate = function(theta){
      var xTemp = this.x;
      var sin = pjs.sin(theta);
      var cos = pjs.cos(theta);
      this.x = this.x*cos - this.y*sin;
      this.y = xTemp*sin + this.y*cos;
    };
  }
  
  pjs.realSetup(pjs);
}

// try to get the sketch instance from Processing.js
function tryFindSketch (callback) {
    var sketch = Processing.getInstanceById(getProcessingSketchId());
    if ( sketch == undefined )
        return setTimeout( function() {
          tryFindSketch(callback)
        }, 200 ); // retry
    
    callback(sketch);
}
