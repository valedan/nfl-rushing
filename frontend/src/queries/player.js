import { gql } from "apollo-boost";

export const GET_PLAYERS = gql`
  query($sortBy: SortBy, $limit: Int, $offset: Int) {
    players(sortBy: $sortBy, limit: $limit, offset: $offset) {
      totalCount
      nodes {
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
  }
`;
