// AnalyzeEcad.groovy
// Detect cells
// Classify cells by tumor marker and Ecad intensity

// ---- Detect all cells in acnnotations ----
selectAnnotations();
runPlugin('qupath.imagej.detect.cells.WatershedCellDetection','{"detectionImage":"DAPI","requestedPixelSizeMicrons":0.498,"backgroundRadiusMicrons":30.0,"backgroundByReconstruction":true,"medianRadiusMicrons":0.0,"sigmaMicrons":1.2,"minAreaMicrons":10.0,"maxAreaMicrons":100.0,"threshold":18.0,"watershedPostProcess":true,"cellExpansionMicrons":2.0,"includeNuclei":true,"smoothBoundaries":true,"makeMeasurements":true}');

// ---- Detect tumor and Ecad positive cells ----
runObjectClassifier("TumorEcad");


