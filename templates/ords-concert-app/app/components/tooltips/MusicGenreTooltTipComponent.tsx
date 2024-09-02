/*
**
** Copyright (c) 2024, Oracle and/or its affiliates.
** All rights reserved
** Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
*/
import featureDescriptions from '../../utils/ORDSFeaturesDescription';
import TooltipComponent from './TooltipComponent';
/**
 * The admin tooltip component, describes the admin actions workflow.
 * @returns the Admin Actions Tooltip Component.
 */
function MusicGenreTooltip() {
  const { musicGenresTooltipDescription } = featureDescriptions;
  return (
    <TooltipComponent featureProps={musicGenresTooltipDescription} width="40px" height="40px" />
  );
}

export default MusicGenreTooltip;
