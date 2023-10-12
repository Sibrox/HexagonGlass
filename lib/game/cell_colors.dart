enum CellColors { primary, secondary, grey }

Map<CellColors, String> cellColorsToString = {
  CellColors.primary: "1",
  CellColors.secondary: "2",
  CellColors.grey: "0"
};

Map<String, CellColors> stringToCellColors = {
  "1": CellColors.primary,
  "2": CellColors.secondary,
  "0": CellColors.grey,
  "-": CellColors.grey
};
