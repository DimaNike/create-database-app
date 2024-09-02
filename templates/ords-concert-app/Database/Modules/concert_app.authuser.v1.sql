-- Copyright (c) 2024, Oracle and/or its affiliates.
-- All rights reserved
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Generated by ORDS REST Data Services 24.2.3.r2011847
-- Schema: CONCERT_SAMPLE_APP  Date: Mon Aug 26 10:21:51 2024 
--

DECLARE
  l_roles     OWA.VC_ARR;
  l_modules   OWA.VC_ARR;
  l_patterns  OWA.VC_ARR;

BEGIN
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_schema              => 'CONCERT_SAMPLE_APP',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'concert_sample_app',
      p_auto_rest_auth      => FALSE);
    
  ORDS.DEFINE_MODULE(
      p_module_name    => 'concert_app.authuser.v1',
      p_base_path      => '/authuser/v1/',
      p_items_per_page => 0,
      p_status         => 'PUBLISHED',
      p_comments       => 'authenticated user APIs Version 1');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'events/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'events resource for authenticated users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'events/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT 
        a.name AS ARTIST_NAME,
        e.event_id AS EVENT_ID,
        e.event_date AS EVENT_DATE,
        e.event_details AS EVENT_DETAILS,
        es.event_status_name as EVENT_STATUS_NAME,
        es.event_status_id AS EVENT_STATUS_ID,
        v.venue_id AS VENUE_ID,
        v.name AS VENUE_NAME
    FROM 
        events e
        INNER JOIN artists a ON e.artist_id = a.artist_id
        INNER JOIN event_status es ON e.event_status_id = es.event_status_id
        INNER JOIN venues v ON e.venue_id = v.venue_id
        ORDER BY e.event_date DESC');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'event/:event_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'event resource for authenticated users');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'event/:event_id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT 
        a.name AS ARTIST_NAME,
        e.event_id AS EVENT_ID,
        e.event_date AS EVENT_DATE,
        e.event_details AS EVENT_DETAILS,
        es.event_status_name as EVENT_STATUS_NAME,
        es.event_status_id AS EVENT_STATUS_ID,
        v.venue_id AS VENUE_ID,
        v.name AS VENUE_NAME
    FROM 
        events e
        INNER JOIN artists a ON e.artist_id = a.artist_id
        INNER JOIN event_status es ON e.event_status_id = es.event_status_id
        INNER JOIN venues v ON e.venue_id = v.venue_id
        WHERE e.event_id = :event_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_artists/:user_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Liked artist of user');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_artists/:user_id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT A.* FROM ARTISTS A 
        JOIN LIKED_ARTIST L_A 
        ON A.ARTIST_ID = L_A.ARTIST_ID
        WHERE L_A.USER_ID = :user_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_artist/:user_id/:artist_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Check if user liked an artist');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_artist/:user_id/:artist_id',
      p_method         => 'GET',
      p_source_type    => 'json/item',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT COUNT(1) as likedArtist FROM LIKED_ARTIST 
        WHERE USER_ID = :user_id AND ARTIST_ID = :artist_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_venues/:user_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Liked venues of user');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_venues/:user_id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT V.* FROM VENUE V 
        JOIN LIKED_VENUE L_V 
        ON V.ID = L_V.VENUE_ID
        WHERE L_V.USER_ID = :user_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_venue/:user_id/:venue_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Check if user liked a venue');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_venue/:user_id/:venue_id',
      p_method         => 'GET',
      p_source_type    => 'json/item',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT COUNT(1) as likedVenue FROM LIKED_VENUE 
        WHERE USER_ID = :user_id AND VENUE_ID = :venue_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_events/:user_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Liked events of user');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_events/:user_id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT E.* FROM EVENTS E 
        JOIN LIKED_EVENT L_E 
        ON E.EVENT_ID = L_E.EVENT_ID
        WHERE L_E.USER_ID = :user_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_event/:user_id/:event_id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Check if user liked an event');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_event/:user_id/:event_id',
      p_method         => 'GET',
      p_source_type    => 'json/item',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT COUNT(1) as likedEvent FROM LIKED_EVENT 
        WHERE USER_ID = :user_id AND EVENT_ID = :event_id');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_artist',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'add an entry to the liked artist table');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_artist',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
      INSERT INTO LIKED_ARTIST(ARTIST_ID, USER_ID)
      VALUES (:ARTIST_ID, :USER_ID);
      :status_code := 201;
      :pv_result := ''ARTIST LIKED SUCCESSFULLY'';
      :pn_status := ''SUCCESS'';
      EXCEPTION 
      WHEN OTHERS THEN 
      :status_code := 400;
      :pv_result := ''UNABLE TO LIKE ARTIST'';
      :pn_status := ''ERROR'';
    END;
        ');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'POST',
      p_name               => 'STATUS_CODE',
      p_bind_variable_name => 'pn_status',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response status');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'POST',
      p_name               => 'RESULT_MESSAGE',
      p_bind_variable_name => 'pv_result',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response message');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'POST',
      p_name               => 'ARTIST_ID ',
      p_bind_variable_name => 'artist_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'id of artists');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'POST',
      p_name               => 'USER_ID ',
      p_bind_variable_name => 'user_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'user id, provided by auth0');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_artist',
      p_method         => 'DELETE',
      p_source_type    => 'plsql/block',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
      DELETE FROM LIKED_ARTIST
      WHERE ARTIST_ID = :ARTIST_ID AND USER_ID = :USER_ID;
      IF SQL%ROWCOUNT = 0 THEN
          :status_code := 404;
          :pv_result := ''Invalid user_id or artist_id number'';
          :pn_status := ''NO_MATCH'';
      ELSE
          :status_code := 200;
          :pv_result := ''UNLIKED ARTIST SUCCESSFULLY'';
          :pn_status := ''SUCCESS'';
      END IF;
      EXCEPTION 
      WHEN OTHERS THEN 
          :status_code := 400;
          :pv_result := ''UNABLE TO UNLIKE '';
          :pn_status := ''ERROR'';
        END;
        ');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'DELETE',
      p_name               => 'STATUS_CODE',
      p_bind_variable_name => 'pn_status',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response status');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'DELETE',
      p_name               => 'RESULT_MESSAGE',
      p_bind_variable_name => 'pv_result',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response message');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'DELETE',
      p_name               => 'ARTIST_ID ',
      p_bind_variable_name => 'artist_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'id of artists');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_artist',
      p_method             => 'DELETE',
      p_name               => 'USER_ID ',
      p_bind_variable_name => 'user_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'user id, provided by auth0');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_venue',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'add an entry to the liked venue table');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_venue',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
      INSERT INTO LIKED_VENUE(VENUE_ID, USER_ID)
      VALUES (:VENUE_ID, :USER_ID);
      :status_code := 201;
      :pv_result := ''VENUE LIKED SUCCESSFULLY'';
      :pn_status := ''SUCCESS'';
      EXCEPTION 
      WHEN OTHERS THEN 
      :status_code := 400;
      :pv_result := ''UNABLE TO LIKE VENUE'';
      :pn_status := ''ERROR'';
    END;
        ');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'POST',
      p_name               => 'STATUS_CODE',
      p_bind_variable_name => 'pn_status',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response status');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'POST',
      p_name               => 'RESULT_MESSAGE',
      p_bind_variable_name => 'pv_result',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response message');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'POST',
      p_name               => 'VENUE_ID ',
      p_bind_variable_name => 'venue_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'id of artists');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'POST',
      p_name               => 'USER_ID ',
      p_bind_variable_name => 'user_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'user id, provided by auth0');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_venue',
      p_method         => 'DELETE',
      p_source_type    => 'json/collection',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
      DELETE FROM LIKED_VENUE 
      WHERE VENUE_ID = :VENUE_ID AND USER_ID = :USER_ID;
      IF SQL%ROWCOUNT = 0 THEN
          :status_code := 404;
          :pv_result := ''Invalid user_id or venue_id number'';
          :pn_status := ''NO_MATCH'';
      ELSE
          :status_code := 200;
          :pv_result := ''UNLIKED VENUE SUCCESSFULLY'';
          :pn_status := ''SUCCESS'';
      END IF;
      EXCEPTION 
      WHEN OTHERS THEN 
      :status_code := 400;
      :PN_RESULT := ''UNABLE TO UNLIKE VENUE'';
      :pn_status := ''ERROR'';
    END;
        ');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'DELETE',
      p_name               => 'STATUS_CODE',
      p_bind_variable_name => 'pn_status',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response status');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'DELETE',
      p_name               => 'RESULT_MESSAGE',
      p_bind_variable_name => 'pv_result',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response message');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'DELETE',
      p_name               => 'VENUE_ID ',
      p_bind_variable_name => 'venue_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'id of artists');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_venue',
      p_method             => 'DELETE',
      p_name               => 'USER_ID ',
      p_bind_variable_name => 'user_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'user id, provided by auth0');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_event',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'add an entry to the liked event table');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_event',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
      INSERT INTO LIKED_EVENT(EVENT_ID, USER_ID)
      VALUES (:EVENT_ID, :USER_ID);
      :status_code := 201;
      :pv_result := ''EVENT LIKED SUCCESSFULLY'';
      :pn_status := ''SUCCESS'';
      EXCEPTION 
      WHEN OTHERS THEN 
          :status_code := 400;
          :pv_result := ''UNABLE TO LIKE EVENT.'';
          :pn_status := ''ERROR'';
    END;
        ');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'POST',
      p_name               => 'STATUS_CODE',
      p_bind_variable_name => 'pn_status',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response status');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'POST',
      p_name               => 'RESULT_MESSAGE',
      p_bind_variable_name => 'pv_result',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response message');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'POST',
      p_name               => 'VENUE_ID ',
      p_bind_variable_name => 'event_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'id of artists');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'POST',
      p_name               => 'USER_ID ',
      p_bind_variable_name => 'user_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'user id, provided by auth0');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'concert_app.authuser.v1',
      p_pattern        => 'liked_event',
      p_method         => 'DELETE',
      p_source_type    => 'plsql/block',
      p_items_per_page => 10,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
      DELETE FROM LIKED_EVENT 
      WHERE EVENT_ID = :EVENT_ID AND USER_ID = :USER_ID;
      IF SQL%ROWCOUNT = 0 THEN
          :status_code := 404;
          :pv_result := ''Invalid user_id or event_id number'';
          :pn_status := ''NO_MATCH'';
      ELSE
          :status_code := 200;
          :pv_result := ''UNLIKED EVENT SUCCESSFULLY'';
          :pn_status := ''SUCCESS'';
      END IF;
      EXCEPTION 
      WHEN OTHERS THEN 
          :status_code := 400;
          :pv_result := ''UNABLE TO UNLIKE EVENT'';
          :pn_status := ''ERROR'';
        END;
        ');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'DELETE',
      p_name               => 'STATUS_CODE',
      p_bind_variable_name => 'pn_status',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response status');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'DELETE',
      p_name               => 'RESULT_MESSAGE',
      p_bind_variable_name => 'pv_result',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => 'Response message');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'DELETE',
      p_name               => 'VENUE_ID ',
      p_bind_variable_name => 'event_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'id of artists');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'concert_app.authuser.v1',
      p_pattern            => 'liked_event',
      p_method             => 'DELETE',
      p_name               => 'USER_ID ',
      p_bind_variable_name => 'user_id',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'user id, provided by auth0');

    
    
  l_modules(1) := 'concert_app.authuser.v1';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'concert_app_authuser',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => 'authenticated end user privilege',
      p_description    => 'Provides access to the user specific endpoints',
      p_comments       => NULL);

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;
        
COMMIT;

END;