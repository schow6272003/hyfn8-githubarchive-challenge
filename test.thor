require 'thor'
require 'big_query'


class GithubArchive < Thor
  EVENTS = ["CommitCommentEvent", "CreateEvent", "DeleteEvent", "DeploymentEvent", "DeploymentStatusEvent", "DownloadEvent", "FollowEvent", "ForkEvent", "ForkApplyEvent", "GistEvent", "GollumEvent", "InstallationEvent", "InstallationRepositoriesEvent", "IssueCommentEvent", "IssuesEvent", "LabelEvent", "MarketplacePurchaseEvent", "MemberEvent", "MembershipEvent", "MilestoneEvent", "OrganizationEvent", "OrgBlockEvent", "PageBuildEvent", "ProjectCardEvent", "ProjectColumnEvent", "ProjectEvent", "PublicEvent", "PullRequestEvent", "PullRequestReviewEvent", "PullRequestReviewCommentEvent", "PushEvent", "ReleaseEvent", "RepositoryEvent", "StatusEvent", "TeamEvent", "TeamAddEvent", "WatchEvent"]

  desc "example", "an example task"
  def example
    puts "I'm a thor task!"
  end
end

