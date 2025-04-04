-- Copyright (c) 2024, Oracle and/or its affiliates.
-- All rights reserved
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Generated by ORDS REST Data Services 24.2.3.r2011847
-- Schema: CONCERT_SAMPLE_APP  Date: Mon Aug 26 10:21:44 2024 
--
        
BEGIN
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_schema              => 'CONCERT_SAMPLE_APP',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'concert_sample_app',
      p_auto_rest_auth      => FALSE);
    
  ORDS.DEFINE_MODULE(
      p_module_name    => 'concert_app.euser.v2',
      p_base_path      => '/euser/v2/',
      p_items_per_page => 0,
      p_status         => 'PUBLISHED',
      p_comments       => 'end user APIs Version 1');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artists/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artists/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT
      A.ARTIST_ID,
      A.NAME,
      A.DESCRIPTION,
      LISTAGG(MG.NAME, '', '') WITHIN GROUP(
      ORDER BY
          MG.NAME
      ) AS MUSIC_GENRES
    FROM
      ARTISTS A
      LEFT JOIN ARTIST_CLASSIFICATIONS AA ON A.ARTIST_ID = AA.ARTIST_ID
      LEFT JOIN MUSIC_GENRES           MG ON AA.MUSIC_GENRE_ID = MG.MUSIC_GENRE_ID
    GROUP BY
      A.ARTIST_ID,
      A.NAME,
      A.DESCRIPTION
    ORDER BY
      A.NAME');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artist/:id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artist/:id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT
      A.ARTIST_ID,
      A.NAME,
      A.DESCRIPTION,
      A.BIO,
      LISTAGG(MG.NAME, '', '') WITHIN GROUP( 
      ORDER BY
          MG.NAME
      ) AS MUSIC_GENRES
    FROM
      ARTISTS A
      LEFT JOIN ARTIST_CLASSIFICATIONS AA ON A.ARTIST_ID = AA.ARTIST_ID
      LEFT JOIN MUSIC_GENRES           MG ON AA.MUSIC_GENRE_ID = MG.MUSIC_GENRE_ID
    WHERE A.ARTIST_ID = :id
    GROUP BY
      A.ARTIST_ID,
      A.NAME,
      A.DESCRIPTION,
      A.BIO
    ORDER BY
      A.NAME');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artists/:artist_name',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artists/:artist_name',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM ARTISTS 
      WHERE NAME LIKE ''%'' || :artist_name || ''%''');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venues/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venues/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM VENUES ORDER BY NAME DESC');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venues/:venue_name',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venues/:venue_name',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM VENUES
    WHERE NAME LIKE ''%'' || :venue_name || ''%''');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'cities/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Cities resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'cities/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT C.CITY_ID, C.NAME, C.DESCRIPTION, COUNT(E.EVENT_ID) AS EVENT_COUNT
      FROM CITIES C
      LEFT JOIN VENUES V ON C.CITY_ID = V.CITY_ID
      LEFT JOIN EVENTS E ON V.VENUE_ID = E.VENUE_ID
      GROUP BY C.CITY_ID, C.NAME, C.DESCRIPTION
      ORDER BY EVENT_COUNT DESC');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venues_by_city/:city_name',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venues_by_city/:city_name',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT V.* 
      FROM VENUES V JOIN CITIES C 
      ON V.CITY_ID = C.CITY_ID
      WHERE C.CITY_NAME = :CITY_NAME
            ');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venue/:venue_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'venue/:venue_id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM VENUES WHERE VENUE_ID = :VENUE_ID');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'events/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'events/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM EVENTS');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'events/:event_name',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Events for the homepage');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'events/:event_name',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM EVENTS_VIEW 
    WHERE ARTIST_NAME LIKE ''%'' || :event_name || ''%''
    ORDER BY EVENT_DATE ASC');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'event/:event_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Artist resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'event/:event_id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM EVENTS_VIEW WHERE EVENT_ID = :event_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'landing_page_global_stats/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Banner stats for end users.');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'landing_page_global_stats/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM BANNER_VIEW');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'eventsHome/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Events for the homepage');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'eventsHome/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM EVENTS_VIEW ORDER BY EVENT_DATE ASC');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artistEvents/:id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Events for a particular Artist.');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'artistEvents/:id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM EVENTS_VIEW WHERE ARTIST_ID = :id ORDER BY EVENT_DATE ASC');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'cityEvents/:cityName',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Events for a particular City.');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'cityEvents/:cityName',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM EVENTS_VIEW WHERE CITY_NAME=:cityName  ORDER BY EVENT_DATE ASC');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'eventStatus/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Event status resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'eventStatus/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM EVENT_STATUS');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'musicGenres/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => ' music genres resource for end users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.euser.v2',
      p_pattern        => 'musicGenres/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * FROM MUSIC_GENRES');
        
COMMIT;

END;