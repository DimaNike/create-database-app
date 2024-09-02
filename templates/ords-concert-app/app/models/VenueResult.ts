/*
**
** Copyright (c) 2024, Oracle and/or its affiliates.
** All rights reserved
** Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
*/
interface VenueResult {
  venue_id: number;
  name: string;
  location: string;
  city_id: number;
  city_name:string;
}

export default VenueResult;
