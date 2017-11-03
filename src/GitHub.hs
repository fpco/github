-----------------------------------------------------------------------------
-- |
-- License     :  BSD-3-Clause
-- Maintainer  :  Oleg Grenrus <oleg.grenrus@iki.fi>
--
-- This module re-exports all request constructrors and data definitions from
-- this package.
--
-- See "GitHub.Request" module for executing 'Request', or other modules
-- of this package (e.g. "GitHub.Users") for already composed versions.
--
-- The missing endpoints lists show which endpoints we know are missing, there
-- might be more.
module GitHub (
    -- * Activity
    -- | See <https://developer.github.com/v3/activity/>

    -- ** Events
    -- | See https://developer.github.com/v3/activity/events/#events
    repositoryEventsR,
    userEventsR,
    -- ** Starring
    -- | See <https://developer.github.com/v3/activity/starring/>
    --
    -- Missing endpoints:
    --
    -- * Check if you are starring a repository
    stargazersForR,
    reposStarredByR,
    myStarredR,
    myStarredAcceptStarR,
    starRepoR,
    unstarRepoR,

    -- ** Watching
    -- | See <https://developer.github.com/v3/activity/>
    --
    -- Missing endpoints:
    --
    -- * Query a Repository Subscription
    -- * Set a Repository Subscription
    -- * Delete a Repository Subscription
    watchersForR,
    reposWatchedByR,

    -- * Gists
    -- | See <https://developer.github.com/v3/gists/>
    --
    -- Missing endpoints:
    --
    -- * Query a specific revision of a gist
    -- * Create a gist
    -- * Edit a gist
    -- * List gist commits
    -- * Star a gist
    -- * Unstar a gist
    -- * Check if a gist is starred
    -- * Fork a gist
    -- * List gist forks
    gistsR,
    gistR,
    deleteGistR,

    -- ** Comments
    -- | See <https://developer.github.com/v3/gists/comments/>
    --
    -- Missing endpoints:
    -- * Create a comment
    -- * Edit a comment
    -- * Delete a comment
    commentsOnR,
    gistCommentR,

    -- * Git Data
    -- | See <https://developer.github.com/v3/git/>

    -- ** Blobs
    -- | See <https://developer.github.com/v3/git/blobs/>
    blobR,

    -- ** Commits
    -- | See <https://developer.github.com/v3/git/commits/>
    gitCommitR,

    -- ** References
    -- | See <https://developer.github.com/v3/git/refs/>
    referenceR,
    referencesR,
    createReferenceR,

    -- ** Trees
    -- | See <https://developer.github.com/v3/git/trees/>
    treeR,
    nestedTreeR,

    -- * Issues
    -- | See <https://developer.github.com/v3/issues/>
    --
    currentUserIssuesR,
    organizationIssuesR,
    issueR,
    issuesForRepoR,
    createIssueR,
    editIssueR,

    -- ** Comments
    -- | See <https://developer.github.com/v3/issues/comments/>
    --
    -- Missing endpoints:
    --
    -- * Delete comment
    commentR,
    commentsR,
    createCommentR,
    editCommentR,

    -- ** Events
    -- | See <https://developer.github.com/v3/issues/events/>
    --
    eventsForIssueR,
    eventsForRepoR,
    eventR,

    -- ** Labels
    -- | See <https://developer.github.com/v3/issues/labels/>
    --
    labelsOnRepoR,
    labelR,
    createLabelR,
    updateLabelR,
    deleteLabelR,
    labelsOnIssueR,
    addLabelsToIssueR,
    removeLabelFromIssueR,
    replaceAllLabelsForIssueR,
    removeAllLabelsFromIssueR,
    labelsOnMilestoneR,

    -- ** Milestone
    -- | See <https://developer.github.com/v3/issues/milestones/>
    --
    -- Missing endpoints:
    --
    -- * Create a milestone
    -- * Update a milestone
    -- * Delete a milestone
    milestonesR,
    milestoneR,

    -- * Organizations
    -- | See <https://developer.github.com/v3/orgs/>
    --
    -- Missing endpoints:
    --
    -- * List your organizations
    -- * List all organizations
    -- * Edit an organization
    publicOrganizationsForR,
    publicOrganizationR,
    -- ** Members
    -- | See <https://developer.github.com/v3/orgs/members/>
    --
    -- Missing endpoints: All except /Members List/
    membersOfR,
    membersOfWithR,

    -- ** Teams
    -- | See <https://developer.github.com/v3/orgs/teams/>
    --
    -- Missing endpoints:
    --
    -- * Query team member (deprecated)
    -- * Add team member (deprecated)
    -- * Remove team member (deprecated)
    -- * Check if a team manages a repository
    -- * Add team repository
    -- * Remove team repository
    teamsOfR,
    teamInfoForR,
    createTeamForR,
    editTeamR,
    deleteTeamR,
    listTeamMembersR,
    listTeamReposR,
    teamMembershipInfoForR,
    addTeamMembershipForR,
    deleteTeamMembershipForR,
    listTeamsCurrentR,

    -- * Pull Requests
    -- | See <https://developer.github.com/v3/pulls/>
    pullRequestsForR,
    pullRequestR,
    createPullRequestR,
    updatePullRequestR,
    pullRequestCommitsR,
    pullRequestFilesR,
    isPullRequestMergedR,
    mergePullRequestR,

    -- ** Review comments
    -- | See <https://developer.github.com/v3/pulls/comments/>
    --
    -- Missing endpoints:
    --
    -- * List comments in a repository
    -- * Create a comment
    -- * Edit a comment
    -- * Delete a comment
    pullRequestCommentsR,
    pullRequestCommentR,

    -- ** Pull request reviews
    -- | See <https://developer.github.com/v3/pulls/reviews/>
    --
    -- Missing endpoints:
    --
    -- * Delete a pending review
    -- * Create a pull request review
    -- * Submit a pull request review
    -- * Dismiss a pull request review
    pullRequestReviewsR,
    pullRequestReviews,
    pullRequestReviews',
    pullRequestReviewR,
    pullRequestReview,
    pullRequestReview',
    pullRequestReviewCommentsR,
    pullRequestReviewCommentsIO,
    pullRequestReviewCommentsIO',

    -- * Repositories
    -- | See <https://developer.github.com/v3/repos/>
    --
    -- Missing endpoints:
    --
    -- * List all public repositories
    -- * List Teams
    -- * Query Branch
    -- * Enabling and disabling branch protection
    currentUserReposR,
    userReposR,
    organizationReposR,
    repositoryR,
    contributorsR,
    languagesForR,
    tagsForR,
    branchesForR,

    -- ** Collaborators
    -- | See <https://developer.github.com/v3/repos/collaborators/>
    collaboratorsOnR,
    isCollaboratorOnR,

    -- ** Comments
    -- | See <https://developer.github.com/v3/repos/comments/>
    --
    -- Missing endpoints:
    --
    -- * Create a commit comment
    -- * Update a commit comment
    -- *  Delete a commit comment
    commentsForR,
    commitCommentsForR,
    commitCommentForR,

    -- ** Commits
    -- | See <https://developer.github.com/v3/repos/commits/>
    commitsForR,
    commitsWithOptionsForR,
    commitR,
    diffR,

    -- ** Forks
    -- | See <https://developer.github.com/v3/repos/forks/>
    --
    -- Missing endpoints:
    --
    -- * Create a fork
    forksForR,

    -- ** Webhooks
    -- | See <https://developer.github.com/v3/repos/hooks/>
    webhooksForR,
    webhookForR,
    createRepoWebhookR,
    editRepoWebhookR,
    testPushRepoWebhookR,
    pingRepoWebhookR,
    deleteRepoWebhookR,

    -- * Releases
    releasesR,
    releaseR,
    latestReleaseR,
    releaseByTagNameR,

    -- * Search
    -- | See <https://developer.github.com/v3/search/>
    --
    -- Missing endpoints:
    --
    -- * Search users
    searchReposR,
    searchCodeR,
    searchIssuesR,

    -- * Users
    -- | See <https://developer.github.com/v3/users/>
    --
    -- Missing endpoints:
    --
    -- * Update the authenticated user
    -- * Query all users
    userInfoForR,
    ownerInfoForR,
    userInfoCurrentR,

    -- ** Followers
    -- | See <https://developer.github.com/v3/users/followers/>
    --
    -- Missing endpoints:
    --
    -- * Check if you are following a user
    -- * Check if one user follows another
    -- * Follow a user
    -- * Unfollow a user
    usersFollowingR,
    usersFollowedByR,

    -- * Data definitions
    module GitHub.Data,
    -- * Request handling
    module GitHub.Request,
    ) where

import GitHub.Data
import GitHub.Endpoints.Activity.Events
import GitHub.Endpoints.Activity.Starring
import GitHub.Endpoints.Activity.Watching
import GitHub.Endpoints.Gists
import GitHub.Endpoints.Gists.Comments
import GitHub.Endpoints.GitData.Blobs
import GitHub.Endpoints.GitData.Commits
import GitHub.Endpoints.GitData.References
import GitHub.Endpoints.GitData.Trees
import GitHub.Endpoints.Issues
import GitHub.Endpoints.Issues.Comments
import GitHub.Endpoints.Issues.Events
import GitHub.Endpoints.Issues.Labels
import GitHub.Endpoints.Issues.Milestones
import GitHub.Endpoints.Organizations
import GitHub.Endpoints.Organizations.Members
import GitHub.Endpoints.Organizations.Teams
import GitHub.Endpoints.PullRequests
import GitHub.Endpoints.PullRequests.Reviews
import GitHub.Endpoints.PullRequests.Comments
import GitHub.Endpoints.Repos
import GitHub.Endpoints.Repos.Collaborators
import GitHub.Endpoints.Repos.Comments
import GitHub.Endpoints.Repos.Commits
import GitHub.Endpoints.Repos.Forks
import GitHub.Endpoints.Repos.Releases
import GitHub.Endpoints.Repos.Webhooks
import GitHub.Endpoints.Search
import GitHub.Endpoints.Users
import GitHub.Endpoints.Users.Followers
import GitHub.Request
