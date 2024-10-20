import 'package:domain/use_case/keyword_suggestions_use_case.dart';
import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:domain/use_case/use_case_list.dart';
import 'package:use_case/github_use_case/github_search_repositories_use_case.dart';

import 'package:infrastructure/github_git_repository/data/github_search_repositories_data.dart';
import 'package:infrastructure/github_git_repository/github_git_repository.dart';

import 'package:use_case/github_use_case/keyword_suggestions/search_repositories_keyword_suggestions_use_case.dart';

class DummySmallDataUseCaseList implements UseCaseList {
  late final _searchRepositoriesUseCase = _DummySearchRepositoriesUseCase();
  late final _keywordSuggestionsUseCase =
      SearchRepositoriesKeywordSuggestionsUseCase();

  @override
  SearchRepositoriesUseCase getSearchRepositoriesUseCase() {
    return _searchRepositoriesUseCase;
  }

  @override
  KeywordSuggestionsUseCase getKeywordSuggestionsUseCase() {
    return _keywordSuggestionsUseCase;
  }
}

class _DummySearchRepositoriesUseCase extends GithubSearchRepositoriesUseCase {
  _DummySearchRepositoriesUseCase() : super(repository: _dummyRepository());
}

class _dummyRepository implements GithubGitRepository {
  @override
  Future<GithubSearchRepositoriesData> searchRepositories(
      String keyword, int page) async {
    await Future.delayed(const Duration(seconds: 2));
    return GithubSearchRepositoriesData(
        totalCount: 1, incompleteResults: false, items: [flutterRepo]);
  }

  @override
  void catchNetworkException(Object e) {}

  @override
  void catchExceptionFromGithub(String message) {}

  RepositoryItem flutterRepo = RepositoryItem(
    id: 31792824,
    nodeId: "MDEwOlJlcG9zaXRvcnkzMTc5MjgyNA==",
    name: "flutter",
    fullName: "flutter/flutter",
    isPrivate: false,
    owner: Owner(
      login: "flutter",
      id: 14101776,
      nodeId: "MDEyOk9yZ2FuaXphdGlvbjE0MTAxNzc2",
      avatarUrl: "https://avatars.githubusercontent.com/u/14101776?v=4",
      gravatarId: "",
      url: "https://api.github.com/users/flutter",
      htmlUrl: "https://github.com/flutter",
      followersUrl: "https://api.github.com/users/flutter/followers",
      followingUrl:
          "https://api.github.com/users/flutter/following{/other_user}",
      gistsUrl: "https://api.github.com/users/flutter/gists{/gist_id}",
      starredUrl: "https://api.github.com/users/flutter/starred{/owner}{/repo}",
      subscriptionsUrl: "https://api.github.com/users/flutter/subscriptions",
      organizationsUrl: "https://api.github.com/users/flutter/orgs",
      reposUrl: "https://api.github.com/users/flutter/repos",
      eventsUrl: "https://api.github.com/users/flutter/events{/privacy}",
      receivedEventsUrl: "https://api.github.com/users/flutter/received_events",
      type: "Organization",
      siteAdmin: false,
    ),
    htmlUrl: "https://github.com/flutter/flutter",
    description:
        "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
    fork: false,
    url: "https://api.github.com/repos/flutter/flutter",
    forksUrl: "https://api.github.com/repos/flutter/flutter/forks",
    keysUrl: "https://api.github.com/repos/flutter/flutter/keys{/key_id}",
    collaboratorsUrl:
        "https://api.github.com/repos/flutter/flutter/collaborators{/collaborator}",
    teamsUrl: "https://api.github.com/repos/flutter/flutter/teams",
    hooksUrl: "https://api.github.com/repos/flutter/flutter/hooks",
    issueEventsUrl:
        "https://api.github.com/repos/flutter/flutter/issues/events{/number}",
    eventsUrl: "https://api.github.com/repos/flutter/flutter/events",
    assigneesUrl:
        "https://api.github.com/repos/flutter/flutter/assignees{/user}",
    branchesUrl:
        "https://api.github.com/repos/flutter/flutter/branches{/branch}",
    tagsUrl: "https://api.github.com/repos/flutter/flutter/tags",
    blobsUrl: "https://api.github.com/repos/flutter/flutter/git/blobs{/sha}",
    gitTagsUrl: "https://api.github.com/repos/flutter/flutter/git/tags{/sha}",
    gitRefsUrl: "https://api.github.com/repos/flutter/flutter/git/refs{/sha}",
    treesUrl: "https://api.github.com/repos/flutter/flutter/git/trees{/sha}",
    statusesUrl: "https://api.github.com/repos/flutter/flutter/statuses/{sha}",
    languagesUrl: "https://api.github.com/repos/flutter/flutter/languages",
    stargazersUrl: "https://api.github.com/repos/flutter/flutter/stargazers",
    contributorsUrl:
        "https://api.github.com/repos/flutter/flutter/contributors",
    subscribersUrl: "https://api.github.com/repos/flutter/flutter/subscribers",
    subscriptionUrl:
        "https://api.github.com/repos/flutter/flutter/subscription",
    commitsUrl: "https://api.github.com/repos/flutter/flutter/commits{/sha}",
    gitCommitsUrl:
        "https://api.github.com/repos/flutter/flutter/git/commits{/sha}",
    commentsUrl:
        "https://api.github.com/repos/flutter/flutter/comments{/number}",
    issueCommentUrl:
        "https://api.github.com/repos/flutter/flutter/issues/comments{/number}",
    contentsUrl:
        "https://api.github.com/repos/flutter/flutter/contents/{+path}",
    compareUrl:
        "https://api.github.com/repos/flutter/flutter/compare/{base}...{head}",
    mergesUrl: "https://api.github.com/repos/flutter/flutter/merges",
    archiveUrl:
        "https://api.github.com/repos/flutter/flutter/{archive_format}{/ref}",
    downloadsUrl: "https://api.github.com/repos/flutter/flutter/downloads",
    issuesUrl: "https://api.github.com/repos/flutter/flutter/issues{/number}",
    pullsUrl: "https://api.github.com/repos/flutter/flutter/pulls{/number}",
    milestonesUrl:
        "https://api.github.com/repos/flutter/flutter/milestones{/number}",
    notificationsUrl:
        "https://api.github.com/repos/flutter/flutter/notifications{?since,all,participating}",
    labelsUrl: "https://api.github.com/repos/flutter/flutter/labels{/name}",
    releasesUrl: "https://api.github.com/repos/flutter/flutter/releases{/id}",
    deploymentsUrl: "https://api.github.com/repos/flutter/flutter/deployments",
    createdAt: "2015-03-06T22:54:58Z",
    updatedAt: "2024-10-13T20:56:50Z",
    pushedAt: "2024-10-13T20:56:54Z",
    gitUrl: "git://github.com/flutter/flutter.git",
    sshUrl: "git@github.com:flutter/flutter.git",
    cloneUrl: "https://github.com/flutter/flutter.git",
    svnUrl: "https://github.com/flutter/flutter",
    homepage: "https://flutter.dev",
    size: 168067,
    stargazersCount: 165427,
    watchersCount: 165427,
    language: "Dart",
    hasIssues: true,
    hasProjects: true,
    hasDownloads: true,
    hasWiki: true,
    hasPages: false,
    hasDiscussions: false,
    forksCount: 27304,
    mirrorUrl: null,
    archived: false,
    disabled: false,
    openIssuesCount: 12695,
    license: License(
      key: "bsd-3-clause",
      name: "BSD 3-Clause \"New\" or \"Revised\" License",
      spdxId: "BSD-3-Clause",
      url: "https://api.github.com/licenses/bsd-3-clause",
      nodeId: "MDc6TGljZW5zZTU=",
    ),
    allowForking: true,
    isTemplate: false,
    webCommitSignoffRequired: false,
    topics: [
      "android",
      "app-framework",
      "cross-platform",
      "dart",
      "desktop",
      "flutter",
      "material-design",
    ],
    visibility: "public",
    forks: 27304,
    openIssues: 12695,
    watchers: 165427,
    defaultBranch: "master",
    score: 1.0,
  );
}
