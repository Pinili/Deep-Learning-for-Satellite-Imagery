; Code created and modified by Justin Baradi
; https://github.com/Pinili/Deep-Learning-for-Satellite-Imagery

; Add the extension to the toolbox. Called automatically on ENVI startup.
pro my_extension_extensions_init
  ; Set compile options
  compile_opt IDL2
  ; Get ENVI session
  e = ENVI(/CURRENT)
  ; Add the extension to a subfolder
  e.AddExtension, 'My Extension', 'my_extension', PATH=''
end

; ENVI Extension code. Called when the toolbox item is chosen.
pro my_extension
  ; Set compile options
  compile_opt IDL2
  ; General error handler
  CATCH, err
  if (err ne 0) then begin
    CATCH, /CANCEL
    if OBJ_VALID(e) then $
      e.ReportError, 'ERROR: ' + !error_state.msg
    MESSAGE, /RESET
    return
  endif

  ;Get ENVI session
  e = ENVI(/CURRENT)
  
  ; Open a Sentinel-2 scene
  file = FILEPATH('MTD_MSIL1C.xml', ROOT_DIR='D:', SUBDIR='T15TWM_20171128T204028') ; insert a real filename here
  raster = e.OpenRaster(file)

  ; Get the 10-meter band group
  bands10m = raster[0]
  ; Get the 20-meter band group
  bands20m = raster[1]
  ; Get the 60-meter band group
  bands60m = raster[2]

  ; Use the spatial reference of the 10-meter
  ; raster to create a common grid definition
  ; for the 20-meter and 60-meter rasters.
  gridTask = ENVITask('BuildGridDefinitionFromRaster')
  gridTask.INPUT_RASTER = bands10m
  gridTask.Execute
  
  ; Re-organize band list
  B01Raster = ENVISubsetRaster(bands60m, BANDS=0)
  B02Raster = ENVISubsetRaster(bands10m, BANDS=0)
  B03Raster = ENVISubsetRaster(bands10m, BANDS=1)
  B04Raster = ENVISubsetRaster(bands10m, BANDS=2)
  B05Raster = ENVISubsetRaster(bands20m, BANDS=0)
  B06Raster = ENVISubsetRaster(bands20m, BANDS=1)
  B07Raster = ENVISubsetRaster(bands20m, BANDS=2)
  B08Raster = ENVISubsetRaster(bands10m, BANDS=3)
  B8ARaster = ENVISubsetRaster(bands20m, BANDS=3)
  B09Raster = ENVISubsetRaster(bands60m, BANDS=1)
  B10Raster = ENVISubsetRaster(bands60m, BANDS=2)
  B11Raster = ENVISubsetRaster(bands20m, BANDS=4)
  B12Raster = ENVISubsetRaster(bands20m, BANDS=5)


  bandlist = [B01Raster, B02Raster, B03Raster, B04Raster, $
    B05Raster, B06Raster, B07Raster, B08Raster, $
    B8ARaster, B09Raster, B10Raster, B11Raster, B12Raster]

  ; Create a layer stack
  layerStack = ENVILayerStackRaster( $
    bandlist, $
    GRID_DEFINITION=gridTask.OUTPUT_GRIDDEFINITION)

  ; Get the collection of data objects currently available in the Data Manager
  DataColl = e.Data

  ; Add the output to the Data Manager
  DataColl.Add, layerStack

  ; Display the result
  view = e.GetView()
  layer = view.CreateLayer(layerStack, /CIR)
  view.Zoom, /FULL_EXTENT
end
