import React from "react";
import styled from "styled-components";
import TableCell from "@material-ui/core/TableCell";
import TableRow from "@material-ui/core/TableRow";
import TableBody from "@material-ui/core/TableBody";

export const StatsTableBody = ({ data }) => {
  return (
    <TableBody>
      {data.players.map((row, index) => {
        return (
          <TableRow hover key={row.name}>
            <TableCell
              component="th"
              id={`tr-${index}`}
              scope="row"
              padding="none"
            >
              {row.name}
            </TableCell>
            <TableCell>{row.team}</TableCell>
            <TableCell>{row.position}</TableCell>
            <TableCell>{row.stats.rushingAttempts}</TableCell>
            <TableCell>{row.stats.rushingAttemptsPerGame}</TableCell>
            <TableCell>{row.stats.totalRushingYards}</TableCell>
            <TableCell>{row.stats.rushingYardsPerAttempt}</TableCell>
            <TableCell>{row.stats.rushingYardsPerGame}</TableCell>
            <TableCell>{row.stats.totalRushingTouchdowns}</TableCell>
            <TableCell>{row.stats.longestRush}</TableCell>
            <TableCell>{row.stats.rushingFirstDowns}</TableCell>
            <TableCell>{row.stats.rushingFirstDownPct}</TableCell>
            <TableCell>{row.stats.rushing20Plus}</TableCell>
            <TableCell>{row.stats.rushing40Plus}</TableCell>
            <TableCell>{row.stats.rushingFumbles}</TableCell>
          </TableRow>
        );
      })}
    </TableBody>
  );
};
