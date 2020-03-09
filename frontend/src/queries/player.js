import { gql } from "apollo-boost";

export const GET_PLAYERS = gql`
  query($sortBy: SortBy) {
    players(sortBy: $sortBy) {
      id
      name
      team
      position
      stats {
        rushingAttempts
        rushingAttemptsPerGame
        totalRushingYards
        rushingYardsPerAttempt
        rushingYardsPerGame
        totalRushingTouchdowns
        longestRush
        rushingFirstDowns
        rushingFirstDownPct
        rushing20Plus
        rushing40Plus
        rushingFumbles
      }
    }
  }
`;
