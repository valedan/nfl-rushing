import React from "react";
import styled from "styled-components";
import TableCell from "@material-ui/core/TableCell";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import TableSortLabel from "@material-ui/core/TableSortLabel";

export const StatsTableHead = ({ order, orderBy, onRequestSort }) => {
  const headCells = [
    { label: "Player", sortable: false, id: "name" },
    { label: "Team", sortable: false, id: "team" },
    { label: "Pos", sortable: false, id: "position" },
    { label: "Att", sortable: true, id: "rushingAttempts" },
    { label: "Att/G", sortable: true, id: "rushingAttemptsPerGame" },
    { label: "Yds", sortable: true, id: "totalRushingYards" },
    { label: "Avg", sortable: true, id: "rushingYardsPerAttempt" },
    { label: "Yds/G", sortable: true, id: "rushingYardsPerGame" },
    { label: "TD", sortable: true, id: "totalRushingTouchdowns" },
    { label: "Lng", sortable: true, id: "longestRush" },
    { label: "1st", sortable: true, id: "rushingFirstDowns" },
    { label: "1st%", sortable: true, id: "rushingFirstDownPct" },
    { label: "20+", sortable: true, id: "rushing20Plus" },
    { label: "40+", sortable: true, id: "rushing40Plus" },
    { label: "FUM", sortable: true, id: "rushingFumbles" }
  ];

  const cellContent = cell => {
    if (cell.sortable) {
      return (
        <TableSortLabel
          active={orderBy === cell.id}
          direction={orderBy === cell.id ? order : "DESC"}
          onClick={event => onRequestSort(event, cell.id)}
        >
          {cell.label}
        </TableSortLabel>
      );
    } else {
      return cell.label;
    }
  };
  return (
    <TableHead>
      <TableRow>
        {headCells.map(headCell => (
          <TableCell
            key={headCell.id}
            sortDirection={orderBy === headCell.id ? order : false}
          >
            {cellContent(headCell)}
          </TableCell>
        ))}
      </TableRow>
    </TableHead>
  );
};
