Web Feature Service (WFS)
=========================

The **1.0.0** and **1.1.0** WFS standards implemented in QGIS Server
provide a HTTP interface to query geographic features from a QGIS
project.
A typical WFS request defines the QGIS project to use and the layer to
query.

Specifications document according to the version number of the service:

- `WFS 1.0.0 <http://portal.opengeospatial.org/files/?artifact_id=7176>`_
- `WFS 1.1.0 <http://portal.opengeospatial.org/files/?artifact_id=8339>`_

Standard requests provided by QGIS Server:

.. csv-table::
   :header: "Request", "Description"
   :widths: auto

   ":ref:`GetCapabilities <qgisserver-wfs-getcapabilities>`", "Returns XML metadata with information about the server"
   ":ref:`GetFeature <qgisserver-wfs-getfeature>`", "Returns a selection of features"
   ":ref:`DescribeFeatureType <qgisserver-wfs-describefeaturetype>`", "Returns a description of feature types and properties"
   ":ref:`Transaction <qgisserver-wfs-transaction>`", "Allows features to be inserted, updated or deleted"


.. _`qgisserver-wfs-getcapabilities`:

GetCapabilities
---------------

Standard parameters for the **GetCapabilities** request according to the
OGC WFS 1.0.0 and 1.1.0 specifications:

.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`SERVICE <qgisserver-wfs-service>`", "Yes", "Name of the service (**WFS**)"
   ":ref:`VERSION <qgisserver-wfs-version>`", "No", "Version of the service"
   ":ref:`REQUEST <qgisserver-wfs-getcapabilities-request>`", "Yes", "Name of the request"

In addition to the standard ones, QGIS Server supports the following
extra parameters:


.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`MAP <qgisserver-wfs-map>`", "Yes", "Specify the QGIS project file"


.. _`qgisserver-wfs-service`:

SERVICE
^^^^^^^

This parameter has to be ``WFS`` in case of the **WFS** service.

For example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &...


.. _`qgisserver-wfs-version`:

VERSION
^^^^^^^

This parameter allows to specify the version of the service to use.
Available values for the ``VERSION`` parameter are:

- ``1.0.0``
- ``1.1.0``

If no version is indicated in the request, then ``1.1.0`` is used by
default.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &VERSION=1.1.0
  &...


.. _`qgisserver-wfs-getcapabilities-request`:

REQUEST
^^^^^^^

This parameter is ``GetCapabilities`` in case of the **GetCapabilities**
request.


.. _`qgisserver-wfs-map`:

MAP
^^^

This parameter allows to define the QGIS project file to use and is mandatory
because a request needs a QGIS project to actually work.

However, the ``QGIS_PROJECT_FILE`` environment variable may be used to define a
default QGIS project. In this specific case, ``MAP`` is no longer a required
parameter. For further information you may refer to
:ref:`server_env_variables`.


.. _`qgisserver-wfs-getfeature`:

GetFeature
----------

Standard parameters for the **GetFeature** request according to the
OGC WFS 1.0.0 and 1.1.0 specifications:

.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`SERVICE <qgisserver-wfs-service>`", "Yes", "Name of the service (**WFS**)"
   ":ref:`VERSION <qgisserver-wfs-version>`", "No", "Version of the service"
   ":ref:`REQUEST <qgisserver-wfs-getfeature-request>`", "Yes", "Name of the request"
   ":ref:`TYPENAME <qgisserver-wfs-getfeature-typename>`", "No", "Name of layers"
   ":ref:`FEATUREID <qgisserver-wfs-getfeature-featureid>`", "No", "Filter the features by ids"
   ":ref:`OUTPUTFORMAT <qgisserver-wfs-getfeature-outputformat>`", "No", "Output Format"
   ":ref:`RESULTTYPE <qgisserver-wfs-getfeature-resulttype>`", "No", "Type of the result"
   ":ref:`PROPERTYNAME <qgisserver-wfs-getfeature-propertyname>`", "No", "Name of properties to return"
   ":ref:`MAXFEATURES <qgisserver-wfs-getfeature-maxfeatures>`", "No", "Maximum number of features to return"
   ":ref:`SRSNAME <qgisserver-wfs-getfeature-srsname>`", "No", "Coordinate reference system"
   ":ref:`FILTER <qgisserver-wfs-getfeature-filter>`", "No", "OGC Filter Encoding"
   ":ref:`BBOX <qgisserver-wfs-getfeature-bbox>`", "No", "Map Extent"
   ":ref:`SORTBY <qgisserver-wfs-getfeature-sortby>`", "No", "Sort the results"


In addition to the standard ones, QGIS Server supports the following
extra parameters:


.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`MAP <qgisserver-wfs-map>`", "Yes", "Specify the QGIS project file"
   ":ref:`STARTINDEX <qgisserver-wfs-getfeature-startindex>`", "No", "Paging"
   ":ref:`GEOMETRYNAME <qgisserver-wfs-getfeature-geometryname>`", "No", "Type of geometry to return"
   ":ref:`EXP_FILTER <qgisserver-wfs-getfeature-expfilter>`", "No", "Expression filtering"


.. _`qgisserver-wfs-getfeature-request`:

REQUEST
^^^^^^^

This parameter is ``GetFeature`` in case of the **GetFeature**
request.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &VERSION=1.1.0
  &REQUEST=GetFeature
  &...


.. _`qgisserver-wfs-getfeature-typename`:

TYPENAME
^^^^^^^^

This parameter allows to specify layer names and is mandatory if ``FEATUREID``
is not set.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &VERSION=1.1.0
  &REQUEST=GetFeature
  &TYPENAME=countries


.. _`qgisserver-wfs-getfeature-featureid`:

FEATUREID
^^^^^^^^^

This parameter allows to specify the ID of a specific feature and is formed
like ``typename.fid,typename.fid,...``.

URL example:

.. code-block:: bash

   http://localhost/qgisserver?
   SERVICE=WFS
   &REQUEST=GetFeature
   &FEATUREID=countries.0,places.1


XML response:

.. code-block:: xml

  <wfs:FeatureCollection xmlns:wfs="http://www.opengis.net/wfs" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml" xmlns:ows="http://www.opengis.net/ows" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:qgs="http://www.qgis.org/gml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.1.0/wfs.xsd http://www.qgis.org/gml http://192.168.1.15/qgisserver?SERVICE=WFS&VERSION=1.1.0&REQUEST=DescribeFeatureType&TYPENAME=countries,places&OUTPUTFORMAT=text/xml; subtype%3Dgml/3.1.1">
    <gml:boundedBy>
      ...
    </gml:boundedBy>
    <gml:featureMember>
      <qgs:countries gml:id="countries.1">
        ...
      </qgs:countries>
    </gml:featureMember>
    <gml:featureMember>
      <qgs:places gml:id="places.1">
        ...
      </qgs:places>
    </gml:featureMember>
  </wfs:FeatureCollection>


.. _`qgisserver-wfs-getfeature-outputformat`:

OUTPUTFORMAT
^^^^^^^^^^^^


This parameter may be used to specify the format of the response. If
``VERSION`` is greater or equal than ``1.1.0``, GML3 is the default format.
Otherwise GML2 is used.

Available values are:

- ``gml2``
-  ``text/xml; subtype=gml/2.1.2``
- ``gml3``
- ``text/xml; subtype=gml/3.1.1``
- ``geojson``
- ``application/vnd.geo+json``,
- ``application/vnd.geo json``
- ``application/geo+json``
- ``application/geo json``
- ``application/json``


URL example:

.. code-block:: bash

   http://localhost/qgisserver?
   SERVICE=WFS
   &REQUEST=GetFeature
   &FEATUREID=countries.0
   &OUTPUTFORMAT=geojson


GeoJSON response:

.. code-block:: json

  {
      "type":"FeatureCollection",
      "bbox":[
          -180,
          -90,
          180,
          83.6236
      ],
      "features":[
          {
              "bbox":[
                  -61.891113,
                  16.989719,
                  -61.666389,
                  17.724998
              ],
              "geometry":{
                  "coordinates":[
                      "..."
                  ],
                  "type":"MultiPolygon"
              },
              "id":"countries.1",
              "properties":{
                  "id":1,
                  "name":"Antigua and Barbuda"
              },
              "type":"Feature"
          }
      ]
  }


.. _`qgisserver-wfs-getfeature-resulttype`:

RESULTTYPE
^^^^^^^^^^

This parameter may be used to specify the kind of result to return.
Available values are:

- ``results``: the default behavior
- ``hits``: returns only a feature count

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &VERSION=1.1.0
  &REQUEST=GetFeature
  &RESULTTYPE=hits
  &...


.. _`qgisserver-wfs-getfeature-propertyname`:

PROPERTYNAME
^^^^^^^^^^^^

This parameter may be used to specify a specific property to return. A property
needs to be mapped with a ``TYPENAME`` or a ``FEATUREID``:

Valid URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &REQUEST=GetFeature
  &PROPERTYNAME=name
  &TYPENAME=places

On the contrary, the next URL will return an exception:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &REQUEST=GetFeature
  &PROPERTYNAME=name
  &TYPENAME=places,countries

.. code-block:: xml

  <ServiceExceptionReport xmlns="http://www.opengis.net/ogc" version="1.2.0">
      <ServiceException code="RequestNotWellFormed">There has to be a 1:1 mapping between each element in a TYPENAME and the PROPERTYNAME list</ServiceException>
  </ServiceExceptionReport>


.. _`qgisserver-wfs-getfeature-maxfeatures`:

MAXFEATURES
^^^^^^^^^^^

This parameter allows to limit the number of features returned by the request.

.. note::

  This parameter may be useful to improve performances when underlying vector
  layers are heavy.


.. _`qgisserver-wfs-getfeature-srsname`:

SRSNAME
^^^^^^^

This parameter allows to indicate the response output Spatial Reference System
as well as the ``BBOX`` CRS and has to be formed like ``EPSG:XXXX``.

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &REQUEST=GetFeature
  &TYPENAME=places
  &SRSNAME=EPSG:32620


.. _`qgisserver-wfs-getfeature-filter`:

FILTER
^^^^^^

This parameter allows to filter the response with the **Filter Encoding**
language defined by the
`OGC Filter Encoding standard <https://www.ogc.org/standards/filter>`_.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS&
  REQUEST=GetFeature&
  TYPENAME=places&
  FILTER=<Filter><PropertyIsEqualTo><PropertyName>name</PropertyName><Literal>Paris</Literal></PropertyIsEqualTo></Filter>


.. _`qgisserver-wfs-getfeature-bbox`:

BBOX
^^^^

This parameter allows to specify the map extent with units according
to the current CRS. Coordinates have to be separated by a comma.

The ``SRSNAME`` parameter may specify the CRS of the extent. If not
specified, the CRS of the layer is used.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &REQUEST=GetFeature
  &TYPENAME=places
  &BBOX=-11.84,42.53,8.46,50.98


The ``FEATUREID`` parameter cannot be used with the ``BBOX``. Any attempt will
result in an exception:

.. code-block:: xml

  <ServiceExceptionReport xmlns="http://www.opengis.net/ogc" version="1.2.0">
    <ServiceException code="RequestNotWellFormed">FEATUREID FILTER and BBOX parameters are mutually exclusive</ServiceException>
  </ServiceExceptionReport>


.. _`qgisserver-wfs-getfeature-sortby`:

SORTBY
^^^^^^

This parameter allows to sort resulting features according to property values
and has to be formed like ``propertyname SORTRULE``.

Available values for ``SORTRULE`` in case of descending sorting:

- ``D``
- ``+D``
- ``DESC``
- ``+DESC``


Available values for ``SORTRULE`` in case of ascending sorting:

- ``A``
- ``+A``
- ``ASC``
- ``+ASC``


URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &REQUEST=GetFeature
  &TYPENAME=places
  &PROPERTYNAME=name
  &MAXFEATURES=3
  &SORTBY=name DESC

The corresponding result:

.. code-block:: xml

  <wfs:FeatureCollection xmlns:wfs="http://www.opengis.net/wfs" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml" xmlns:ows="http://www.opengis.net/ows" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:qgs="http://www.qgis.org/gml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.1.0/wfs.xsd http://www.qgis.org/gml http://192.168.1.15/qgisserver?SERVICE=WFS&VERSION=1.1.0&REQUEST=DescribeFeatureType&TYPENAME=places&OUTPUTFORMAT=text/xml; subtype%3Dgml/3.1.1">
      <gml:boundedBy>
          ...
      </gml:boundedBy>
      <gml:featureMember>
          <qgs:places gml:id="places.90">
              <qgs:name>Zagreb</qgs:name>
          </qgs:places>
      </gml:featureMember>
      <gml:featureMember>
          <qgs:places gml:id="places.113">
              <qgs:name>Yerevan</qgs:name>
          </qgs:places>
      </gml:featureMember>
      <gml:featureMember>
          <qgs:places gml:id="places.111">
              <qgs:name>Yaounde</qgs:name>
          </qgs:places>
      </gml:featureMember>
  </wfs:FeatureCollection>


.. _`qgisserver-wfs-getfeature-geometryname`:

GEOMETRYNAME
^^^^^^^^^^^^

This parameter can be used to specify the kind of geometry to return
for features. Available values are:

- ``extent``
- ``centroid``
- ``bash``

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &VERSION=1.1.0
  &REQUEST=GetFeature
  &GEOMETRYNAME=centroid
  &...


.. _`qgisserver-wfs-getfeature-startindex`:

STARTINDEX
^^^^^^^^^^

This parameter is standard in WFS 2.0, but it's an extension for WFS
1.0.0.

Actually, it can be used to skip some features in the result set and
in combination with ``MAXFEATURES``, it provides the ability to page
through results.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &VERSION=1.1.0
  &REQUEST=GetFeature
  &STARTINDEX=2
  &...


.. _`qgisserver-wfs-getfeature-expfilter`:

EXP_FILTER
^^^^^^^^^^

This parameter allows to filter the response with QGIS expressions.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS&
  REQUEST=GetFeature&
  TYPENAME=places&
  EXP_FILTER="name"='Paris'


.. _`qgisserver-wfs-describefeaturetype`:

DescribeFeatureType
-------------------

Standard parameters for the **DescribeFeatureType** request according to the
OGC WFS 1.0.0 and 1.1.0 specifications:

.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`SERVICE <qgisserver-wfs-service>`", "Yes", "Name of the service (**WFS**)"
   ":ref:`VERSION <qgisserver-wfs-version>`", "No", "Version of the service"
   ":ref:`REQUEST <qgisserver-wfs-describefeaturetype-request>`", "Yes", "Name of the request (**DescribeFeatureType**)"
   ":ref:`OUTPUTFORMAT <qgisserver-wfs-getfeature-outputformat>`", "No", "Format of the response"
   ":ref:`TYPENAME <qgisserver-wfs-describefeaturetype-typename>`", "No", "Name of layer"


In addition to the standard ones, QGIS Server supports the following
extra parameters:


.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`MAP <qgisserver-wfs-map>`", "Yes", "Specify the QGIS project file"


.. _`qgisserver-wfs-describefeaturetype-request`:

REQUEST
^^^^^^^

This parameter is ``DescribeFeatureType`` in case of the
**DescribeFeatureType** request.


.. _`qgisserver-wfs-describefeaturetype-typename`:

TYPENAME
^^^^^^^^

This parameter allows to specify layer names. Names have to be separated by a
comma.

URL example:

.. code-block:: bash

  http://localhost/qgisserver?
  SERVICE=WFS
  &VERSION=1.1.0
  &REQUEST=DescribeFeatureType
  &TYPENAME=countries

Output response:

.. code-block:: xml

  <schema xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:qgs="http://www.qgis.org/gml" xmlns:gml="http://www.opengis.net/gml" targetNamespace="http://www.qgis.org/gml" version="1.0" elementFormDefault="qualified">
    <import schemaLocation="http://schemas.opengis.net/gml/3.1.1/base/gml.xsd" namespace="http://www.opengis.net/gml"/>
    <element type="qgs:countriesType" substitutionGroup="gml:_Feature" name="countries"/>
    <complexType name="countriesType">
      <complexContent>
        <extension base="gml:AbstractFeatureType">
          <sequence>
            <element minOccurs="0" type="gml:MultiPolygonPropertyType" maxOccurs="1" name="geometry"/>
            <element type="long" name="id"/>
            <element nillable="true" type="string" name="name"/>
          </sequence>
        </extension>
      </complexContent>
    </complexType>
  </schema>


.. _`qgisserver-wfs-transaction`:

Transaction
-----------

The ``TRANSACTION`` request allows to update, delete or add one or several
features thanks to a XML document. The **delete** action may be achieved with a
POST document as well as with the ``OPERATION`` parameter while the **add** and
the **update** operations may be achieved through POST request only.

Standard parameters for the **Transaction** request according to the OGC WFS
1.0.0 and 1.1.0 specifications:

.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`SERVICE <qgisserver-wfs-service>`", "Yes", "Name of the service (**WFS**)"
   ":ref:`VERSION <qgisserver-wfs-version>`", "No", "Version of the service"
   ":ref:`REQUEST <qgisserver-wfs-transaction-request>`", "Yes", "Name of the request (**Transaction**)"
   ":ref:`TYPENAME <qgisserver-wfs-describefeaturetype-typename>`", "No", "Name of layer"


In addition to the standard ones, QGIS Server supports the following
extra parameters:


.. csv-table::
   :header: "Parameter", "Required", "Description"
   :widths: auto

   ":ref:`MAP <qgisserver-wfs-map>`", "Yes", "Specify the QGIS project file"
   ":ref:`OPERATION <qgisserver-wfs-transaction-operation>`", "Yes", "Specify the operation"

ADD
^^^

POST request:

.. code-block:: bash

  wget --post-file=add.xml "http://localhost/qgisserver?SERVICE=WFS&REQUEST=TRANSACTION"


with the *add.xml* document:

.. code-block:: xml

  <?xml version="1.0" encoding="UTF-8"?>
  <wfs:Transaction service="WFS" version="1.0.0" xmlns:wfs="http://www.opengis.net/wfs" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ogc="http://www.opengis.net/ogc" xmlns="http://www.opengis.net/wfs" updateSequence="0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.0.0/WFS-capabilities.xsd" xmlns:gml="http://www.opengis.net/gml"  xmlns:ows="http://www.opengis.net/ows">
    <wfs:Insert idgen="GenerateNew">
      <qgs:places>
        <qgs:geometry>
          <gml:Point srsDimension="2" srsName="http://www.opengis.net/def/crs/EPSG/0/4326">
            <gml:coordinates decimal="." cs="," ts=" ">-4.6167,48.3833</gml:coordinates>
          </gml:Point>
        </qgs:geometry>
        <qgs:name>Locmaria-Plouzané</qgs:name>
      </qgs:places>
    </wfs:Insert>
  </wfs:Transaction>

The XML response indicates that the new place has been added with success to
the underlying dataset:

.. code-block:: xml

  <WFS_TransactionResponse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.0.0/wfs.xsd" xmlns="http://www.opengis.net/wfs" version="1.0.0" xmlns:ogc="http://www.opengis.net/ogc">
      <InsertResult>
          <ogc:FeatureId fid="places."/>
      </InsertResult>
      <TransactionResult>
          <Status>
              <SUCCESS/>
           </Status>
      </TransactionResult>
  </WFS_TransactionResponse>
