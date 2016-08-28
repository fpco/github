-----------------------------------------------------------------------------
-- |
-- License     :  BSD-3-Clause
-- Maintainer  :  Oleg Grenrus <oleg.grenrus@iki.fi>
--
module GitHub.Data.Issues where

import GitHub.Data.Definitions
import GitHub.Data.Id           (Id)
import GitHub.Data.PullRequests
import GitHub.Data.URL          (URL)
import GitHub.Internal.Prelude

data Issue = Issue {
   issueClosedAt    :: Maybe UTCTime
  ,issueUpdatedAt   :: UTCTime
  ,issueEventsUrl   :: URL
  ,issueHtmlUrl     :: Maybe URL
  ,issueClosedBy    :: Maybe SimpleUser
  ,issueLabels      :: (Vector IssueLabel)
  ,issueNumber      :: Int
  ,issueAssignee    :: Maybe SimpleUser
  ,issueUser        :: SimpleUser
  ,issueTitle       :: Text
  ,issuePullRequest :: Maybe PullRequestReference
  ,issueUrl         :: URL
  ,issueCreatedAt   :: UTCTime
  ,issueBody        :: Maybe Text
  ,issueState       :: Text
  ,issueId          :: Id Issue
  ,issueComments    :: Int
  ,issueMilestone   :: Maybe Milestone
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData Issue where rnf = genericRnf
instance Binary Issue

data NewIssue = NewIssue {
  newIssueTitle     :: Text
, newIssueBody      :: Maybe Text
, newIssueAssignee  :: Maybe Text
, newIssueMilestone :: Maybe Int
, newIssueLabels    :: Maybe (Vector Text)
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData NewIssue where rnf = genericRnf
instance Binary NewIssue

data EditIssue = EditIssue {
  editIssueTitle     :: Maybe Text
, editIssueBody      :: Maybe Text
, editIssueAssignee  :: Maybe Text
, editIssueState     :: Maybe Text
, editIssueMilestone :: Maybe Int
, editIssueLabels    :: Maybe (Vector Text)
} deriving  (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData EditIssue where rnf = genericRnf
instance Binary EditIssue

data Milestone = Milestone {
   milestoneCreator      :: SimpleUser
  ,milestoneDueOn        :: Maybe UTCTime
  ,milestoneOpenIssues   :: Int
  ,milestoneNumber       :: Int
  ,milestoneClosedIssues :: Int
  ,milestoneDescription  :: Maybe Text
  ,milestoneTitle        :: Text
  ,milestoneUrl          :: URL
  ,milestoneCreatedAt    :: UTCTime
  ,milestoneState        :: Text
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData Milestone where rnf = genericRnf
instance Binary Milestone

data IssueLabel = IssueLabel {
   labelColor :: Text
  ,labelUrl   :: URL
  ,labelName  :: Text
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData IssueLabel where rnf = genericRnf
instance Binary IssueLabel

data IssueComment = IssueComment {
   issueCommentUpdatedAt :: UTCTime
  ,issueCommentUser      :: SimpleUser
  ,issueCommentUrl       :: URL
  ,issueCommentHtmlUrl   :: URL
  ,issueCommentCreatedAt :: UTCTime
  ,issueCommentBody      :: Text
  ,issueCommentId        :: Int
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData IssueComment where rnf = genericRnf
instance Binary IssueComment

data EventType =
    Mentioned     -- ^ The actor was @mentioned in an issue body.
  | Subscribed    -- ^ The actor subscribed to receive notifications for an issue.
  | Unsubscribed  -- ^ The issue was unsubscribed from by the actor.
  | Referenced    -- ^ The issue was referenced from a commit message. The commit_id attribute is the commit SHA1 of where that happened.
  | Merged        -- ^ The issue was merged by the actor. The commit_id attribute is the SHA1 of the HEAD commit that was merged.
  | Assigned      -- ^ The issue was assigned to the actor.
  | Closed        -- ^ The issue was closed by the actor. When the commit_id is present, it identifies the commit that closed the issue using “closes / fixes #NN” syntax.
  | Reopened      -- ^ The issue was reopened by the actor.
  | ActorUnassigned    -- ^ The issue was unassigned to the actor
  | Labeled       -- ^ A label was added to the issue.
  | Unlabeled     -- ^ A label was removed from the issue.
  | Milestoned    -- ^ The issue was added to a milestone.
  | Demilestoned  -- ^ The issue was removed from a milestone.
  | Renamed       -- ^ The issue title was changed.
  | Locked        -- ^ The issue was locked by the actor.
  | Unlocked      -- ^ The issue was unlocked by the actor.
  | HeadRefDeleted -- ^ The pull request’s branch was deleted.
  | HeadRefRestored -- ^ The pull request’s branch was restored.
  deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData EventType where rnf = genericRnf
instance Binary EventType

-- | Issue event
data Event = Event {
   eventActor     :: !SimpleUser
  ,eventType      :: !EventType
  ,eventCommitId  :: !(Maybe Text)
  ,eventUrl       :: !URL
  ,eventCreatedAt :: !UTCTime
  ,eventId        :: !Int
  ,eventIssue     :: !(Maybe Issue)
} deriving (Show, Data, Typeable, Eq, Ord, Generic)

instance NFData Event where rnf = genericRnf
instance Binary Event

-- | A data structure for describing how to filter issues. This is used by
-- @issuesForRepo@.
data IssueLimitation =
      AnyMilestone -- ^ Issues appearing in any milestone. [default]
    | NoMilestone -- ^ Issues without a milestone.
    | MilestoneId Int -- ^ Only issues that are in the milestone with the given id.
    | Open -- ^ Only open issues. [default]
    | OnlyClosed -- ^ Only closed issues.
    | Unassigned -- ^ Issues to which no one has been assigned ownership.
    | AnyAssignment -- ^ All issues regardless of assignment. [default]
    | AssignedTo String -- ^ Only issues assigned to the user with the given login.
    | Mentions String -- ^ Issues which mention the given string, taken to be a user's login.
    | Labels [String] -- ^ A list of labels to filter by.
    | Ascending -- ^ Sort ascending.
    | Descending -- ^ Sort descending. [default]
    | Since UTCTime -- ^ Only issues created since the specified date and time.
    | PerPage Int -- ^ Download this many issues per query
  deriving (Eq, Ord, Show, Typeable, Data, Generic)

instance NFData IssueLimitation where rnf = genericRnf
instance Binary IssueLimitation

-- JSON instances

instance FromJSON Event where
  parseJSON = withObject "Event" $ \o ->
    Event <$> o .: "actor"
          <*> o .: "event"
          <*> o .:? "commit_id"
          <*> o .: "url"
          <*> o .: "created_at"
          <*> o .: "id"
          <*> o .:? "issue"

instance FromJSON EventType where
  parseJSON (String "closed") = pure Closed
  parseJSON (String "reopened") = pure Reopened
  parseJSON (String "subscribed") = pure Subscribed
  parseJSON (String "merged") = pure Merged
  parseJSON (String "referenced") = pure Referenced
  parseJSON (String "mentioned") = pure Mentioned
  parseJSON (String "assigned") = pure Assigned
  parseJSON (String "unsubscribed") = pure Unsubscribed
  parseJSON (String "unassigned") = pure ActorUnassigned
  parseJSON (String "labeled") = pure Labeled
  parseJSON (String "unlabeled") = pure Unlabeled
  parseJSON (String "milestoned") = pure Milestoned
  parseJSON (String "demilestoned") = pure Demilestoned
  parseJSON (String "renamed") = pure Renamed
  parseJSON (String "locked") = pure Locked
  parseJSON (String "unlocked") = pure Unlocked
  parseJSON (String "head_ref_deleted") = pure HeadRefDeleted
  parseJSON (String "head_ref_restored") = pure HeadRefRestored
  parseJSON _ = fail "Could not build an EventType"

instance FromJSON IssueLabel where
  parseJSON = withObject "IssueLabel" $ \o ->
    IssueLabel <$> o .: "color"
               <*> o .: "url"
               <*> o .: "name"

instance FromJSON IssueComment where
  parseJSON = withObject "IssueComment" $ \o ->
    IssueComment <$> o .: "updated_at"
                 <*> o .: "user"
                 <*> o .: "url"
                 <*> o .: "html_url"
                 <*> o .: "created_at"
                 <*> o .: "body"
                 <*> o .: "id"

instance FromJSON Issue where
  parseJSON = withObject "Issue" $ \o ->
    Issue <$> o .:? "closed_at"
          <*> o .: "updated_at"
          <*> o .: "events_url"
          <*> o .: "html_url"
          <*> o .:? "closed_by"
          <*> o .: "labels"
          <*> o .: "number"
          <*> o .:? "assignee"
          <*> o .: "user"
          <*> o .: "title"
          <*> o .:? "pull_request"
          <*> o .: "url"
          <*> o .: "created_at"
          <*> o .: "body"
          <*> o .: "state"
          <*> o .: "id"
          <*> o .: "comments"
          <*> o .:? "milestone"

instance ToJSON NewIssue where
  toJSON (NewIssue t b a m Nothing) =
    object
    [ "title"     .= t
    , "body"      .= b
    , "assignee"  .= a
    , "milestone" .= m
    -- If there are no labels, than the output should be an empty array.
    , "labels"    .= () ]

  toJSON (NewIssue t b a m ls) =
    object
    [ "title"     .= t
    , "body"      .= b
    , "assignee"  .= a
    , "milestone" .= m
    , "labels"    .= ls ]

instance ToJSON EditIssue where
  toJSON (EditIssue t b a s m ls) =
    object $ filter notNull $ [ "title" .= t
                              , "body" .= b
                              , "assignee" .= a
                              , "state" .= s
                              , "milestone" .= m
                              , "labels" .= ls ]
    where notNull (_, Null) = False
          notNull (_, _)    = True

instance FromJSON Milestone where
  parseJSON = withObject "Milestone" $ \o ->
    Milestone <$> o .: "creator"
              <*> o .: "due_on"
              <*> o .: "open_issues"
              <*> o .: "number"
              <*> o .: "closed_issues"
              <*> o .: "description"
              <*> o .: "title"
              <*> o .: "url"
              <*> o .: "created_at"
              <*> o .: "state"
