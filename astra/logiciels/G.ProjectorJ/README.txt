
G.PROJECTOR

Introduction

  G.Projector is a Java application that enablesen you to explore a large collection of global
  and regional map projections and optionally re-project an input GIF, JPEG or PNG map image.
  The input map image must use the equirectangular projection or the cylindrical equal-area,
  Robinson or Winkel Tripel projection. Some KMZ files may also be used for input. Lon-lat
  gridlines and continental outlines may be drawn on the map, and the resulting map images may
  be saved to disk in GIF, JPEG, PDF, PNG, PS or TIFF form.

  G.Projector requires that a Java 9 (or later) Runtime Environment be installed on your
  computer.


Downloading

  The current version of G.Projector, along with other information about the application,
  may always be found at
  https://www.giss.nasa.gov/tools/gprojector/


Installing and running the "Generic" G.Projector Package

  After uncompressing the downloaded G.Projector archive, simply move the G.Projector folder to
  wherever you prefer to keep your applications programs on your PC.

  The uncompressed package should include the following items:

  - Java application G.Projector.jar and library *.jar files in a sub-directory called "jars".
  - Shell script gprojector.sh that launches the G.Projector Java app.
  - Sample input map images in a sub-directory called "sample_maps".
  - This README file.
  
  On most platforms, you may be able to launch G.Projector by double-clicking on the
  G.Projector.jar icon on the desktop. However, doing so means that G.Projector will be
  allocated Java's default memory request, which might not be enough to work with large input
  map images.

  Instead, you should try running G.Projector from the shell command line; 'cd' into the
  directory where the above files are located and then type:
  
  ./gprojector.sh

  This should execute a command in the shell file that starts G.Projector and requests that it be
  allocated 2 GB of memory. If your computer has a lot of memory available, you can alter
  G.Projector's memory request by editing gprojector.sh and changing the parameter specified for
  the -Xmx option from "2000m" (2000 MB) to something larger. You would most likely want to do
  this if the maximum output image size is smaller than you need.


Continent Overlays Files

  If you are looking for additional overlay files compatible with G.Projector, any of the
  optional "outline overlays" available from the Panoply software website may be used. See
  https://www.giss.nasa.gov/tools/panoply/overlays/

  G.Projector can also use many outline or multipoint SHP shapefiles as overlays.

  To add an overlay to G.Projector's library, go to its Preferences window, select the
  Overlays tab, and click the "+" icon at lower left of the table listing of overlays.


Help and Other Documentation

  More details about using G.Projector are available at:
  https://www.giss.nasa.gov/tools/gprojector/help/


Contact

  Please send bug reports, etc., to the developer

  Robert B. Schmunk
  robert.b.schmunk@nasa.gov
  NASA Goddard Institute for Space Studies
  2880 Broadway, New York, NY 10025 USA


Acknowledgments

  G.Projector uses some Java classes and libraries written by third-party developers. A list,
  with hyperlinks to pertinent websites containing license information and source code, may be
  found in G.Projector's help windows or on the G.Projector website.
