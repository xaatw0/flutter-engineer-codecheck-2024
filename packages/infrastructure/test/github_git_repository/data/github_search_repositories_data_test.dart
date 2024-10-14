// github_search_repositories_data_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import 'package:infrastructure/github_git_repository/data/github_search_repositories_data.dart';

void main() {
  group('GithubSearchRepositoriesData Tests', () {
    test('1. コンストラクタからクラスを作成し、全てのフィールドをテスト', () {
      // Owner
      final owner = Owner(
        login: 'flutter',
        id: 14101776,
        nodeId: 'MDEyOk9yZ2FuaXphdGlvbjE0MTAxNzc2',
        avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        gravatarId: '',
        url: 'https://api.github.com/users/flutter',
        htmlUrl: 'https://github.com/flutter',
        followersUrl: 'https://api.github.com/users/flutter/followers',
        followingUrl:
            'https://api.github.com/users/flutter/following{/other_user}',
        gistsUrl: 'https://api.github.com/users/flutter/gists{/gist_id}',
        starredUrl:
            'https://api.github.com/users/flutter/starred{/owner}{/repo}',
        subscriptionsUrl: 'https://api.github.com/users/flutter/subscriptions',
        organizationsUrl: 'https://api.github.com/users/flutter/orgs',
        reposUrl: 'https://api.github.com/users/flutter/repos',
        eventsUrl: 'https://api.github.com/users/flutter/events{/privacy}',
        receivedEventsUrl:
            'https://api.github.com/users/flutter/received_events',
        type: 'Organization',
        siteAdmin: false,
      );

      // License
      final license = License(
        key: 'bsd-3-clause',
        name: 'BSD 3-Clause "New" or "Revised" License',
        spdxId: 'BSD-3-Clause',
        url: 'https://api.github.com/licenses/bsd-3-clause',
        nodeId: 'MDc6TGljZW5zZTU=',
      );

      // RepositoryItem
      final repositoryItem = RepositoryItem(
        id: 31792824,
        nodeId: 'MDEwOlJlcG9zaXRvcnkzMTc5MjgyNA==',
        name: 'flutter',
        fullName: 'flutter/flutter',
        isPrivate: false,
        owner: owner,
        htmlUrl: 'https://github.com/flutter/flutter',
        description:
            'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
        fork: false,
        url: 'https://api.github.com/repos/flutter/flutter',
        forksUrl: 'https://api.github.com/repos/flutter/flutter/forks',
        keysUrl: 'https://api.github.com/repos/flutter/flutter/keys{/key_id}',
        collaboratorsUrl:
            'https://api.github.com/repos/flutter/flutter/collaborators{/collaborator}',
        teamsUrl: 'https://api.github.com/repos/flutter/flutter/teams',
        hooksUrl: 'https://api.github.com/repos/flutter/flutter/hooks',
        issueEventsUrl:
            'https://api.github.com/repos/flutter/flutter/issues/events{/number}',
        eventsUrl: 'https://api.github.com/repos/flutter/flutter/events',
        assigneesUrl:
            'https://api.github.com/repos/flutter/flutter/assignees{/user}',
        branchesUrl:
            'https://api.github.com/repos/flutter/flutter/branches{/branch}',
        tagsUrl: 'https://api.github.com/repos/flutter/flutter/tags',
        blobsUrl:
            'https://api.github.com/repos/flutter/flutter/git/blobs{/sha}',
        gitTagsUrl:
            'https://api.github.com/repos/flutter/flutter/git/tags{/sha}',
        gitRefsUrl:
            'https://api.github.com/repos/flutter/flutter/git/refs{/sha}',
        treesUrl:
            'https://api.github.com/repos/flutter/flutter/git/trees{/sha}',
        statusesUrl:
            'https://api.github.com/repos/flutter/flutter/statuses/{sha}',
        languagesUrl: 'https://api.github.com/repos/flutter/flutter/languages',
        stargazersUrl:
            'https://api.github.com/repos/flutter/flutter/stargazers',
        contributorsUrl:
            'https://api.github.com/repos/flutter/flutter/contributors',
        subscribersUrl:
            'https://api.github.com/repos/flutter/flutter/subscribers',
        subscriptionUrl:
            'https://api.github.com/repos/flutter/flutter/subscription',
        commitsUrl:
            'https://api.github.com/repos/flutter/flutter/commits{/sha}',
        gitCommitsUrl:
            'https://api.github.com/repos/flutter/flutter/git/commits{/sha}',
        commentsUrl:
            'https://api.github.com/repos/flutter/flutter/comments{/number}',
        issueCommentUrl:
            'https://api.github.com/repos/flutter/flutter/issues/comments{/number}',
        contentsUrl:
            'https://api.github.com/repos/flutter/flutter/contents/{+path}',
        compareUrl:
            'https://api.github.com/repos/flutter/flutter/compare/{base}...{head}',
        mergesUrl: 'https://api.github.com/repos/flutter/flutter/merges',
        archiveUrl:
            'https://api.github.com/repos/flutter/flutter/{archive_format}{/ref}',
        downloadsUrl: 'https://api.github.com/repos/flutter/flutter/downloads',
        issuesUrl:
            'https://api.github.com/repos/flutter/flutter/issues{/number}',
        pullsUrl: 'https://api.github.com/repos/flutter/flutter/pulls{/number}',
        milestonesUrl:
            'https://api.github.com/repos/flutter/flutter/milestones{/number}',
        notificationsUrl:
            'https://api.github.com/repos/flutter/flutter/notifications{?since,all,participating}',
        labelsUrl: 'https://api.github.com/repos/flutter/flutter/labels{/name}',
        releasesUrl:
            'https://api.github.com/repos/flutter/flutter/releases{/id}',
        deploymentsUrl:
            'https://api.github.com/repos/flutter/flutter/deployments',
        createdAt: '2015-03-06T22:54:58Z',
        updatedAt: '2024-10-13T20:56:50Z',
        pushedAt: '2024-10-13T20:56:54Z',
        gitUrl: 'git://github.com/flutter/flutter.git',
        sshUrl: 'git@github.com:flutter/flutter.git',
        cloneUrl: 'https://github.com/flutter/flutter.git',
        svnUrl: 'https://github.com/flutter/flutter',
        homepage: 'https://flutter.dev',
        size: 168067,
        stargazersCount: 165427,
        watchersCount: 165427,
        language: 'Dart',
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
        license: license,
        allowForking: true,
        isTemplate: false,
        webCommitSignoffRequired: false,
        topics: [
          "android",
          "app-framework",
          "cross-platform",
          "dart",
          "dart-platform",
          "desktop",
          "flutter",
          "flutter-package",
          "fuchsia",
          "ios",
          "linux-desktop",
          "macos",
          "material-design",
          "mobile",
          "mobile-development",
          "skia",
          "web",
          "web-framework",
          "windows"
        ],
        visibility: 'public',
        forks: 27304,
        openIssues: 12695,
        watchers: 165427,
        defaultBranch: 'master',
        score: 1.0,
      );

      // GithubSearchRepositoriesData
      final data = GithubSearchRepositoriesData(
        totalCount: 750330,
        incompleteResults: false,
        items: [repositoryItem],
      );

      // Assertions
      expect(data.totalCount, 750330);
      expect(data.incompleteResults, false);
      expect(data.items.length, 1);

      final item = data.items.first;
      expect(item.id, 31792824);
      expect(item.nodeId, 'MDEwOlJlcG9zaXRvcnkzMTc5MjgyNA==');
      expect(item.name, 'flutter');
      expect(item.fullName, 'flutter/flutter');
      expect(item.isPrivate, false);
      expect(item.owner.login, 'flutter');
      expect(item.owner.id, 14101776);
      expect(item.owner.nodeId, 'MDEyOk9yZ2FuaXphdGlvbjE0MTAxNzc2');
      expect(item.owner.avatarUrl,
          'https://avatars.githubusercontent.com/u/14101776?v=4');
      expect(item.owner.gravatarId, '');
      expect(item.owner.url, 'https://api.github.com/users/flutter');
      expect(item.owner.htmlUrl, 'https://github.com/flutter');
      expect(item.owner.followersUrl,
          'https://api.github.com/users/flutter/followers');
      expect(item.owner.followingUrl,
          'https://api.github.com/users/flutter/following{/other_user}');
      expect(item.owner.gistsUrl,
          'https://api.github.com/users/flutter/gists{/gist_id}');
      expect(item.owner.starredUrl,
          'https://api.github.com/users/flutter/starred{/owner}{/repo}');
      expect(item.owner.subscriptionsUrl,
          'https://api.github.com/users/flutter/subscriptions');
      expect(item.owner.organizationsUrl,
          'https://api.github.com/users/flutter/orgs');
      expect(item.owner.reposUrl, 'https://api.github.com/users/flutter/repos');
      expect(item.owner.eventsUrl,
          'https://api.github.com/users/flutter/events{/privacy}');
      expect(item.owner.receivedEventsUrl,
          'https://api.github.com/users/flutter/received_events');
      expect(item.owner.type, 'Organization');
      expect(item.owner.siteAdmin, false);
      expect(item.htmlUrl, 'https://github.com/flutter/flutter');
      expect(item.description,
          'Flutter makes it easy and fast to build beautiful apps for mobile and beyond');
      expect(item.fork, false);
      expect(item.url, 'https://api.github.com/repos/flutter/flutter');
      expect(
          item.forksUrl, 'https://api.github.com/repos/flutter/flutter/forks');
      expect(item.keysUrl,
          'https://api.github.com/repos/flutter/flutter/keys{/key_id}');
      expect(item.collaboratorsUrl,
          'https://api.github.com/repos/flutter/flutter/collaborators{/collaborator}');
      expect(
          item.teamsUrl, 'https://api.github.com/repos/flutter/flutter/teams');
      expect(
          item.hooksUrl, 'https://api.github.com/repos/flutter/flutter/hooks');
      expect(item.issueEventsUrl,
          'https://api.github.com/repos/flutter/flutter/issues/events{/number}');
      expect(item.eventsUrl,
          'https://api.github.com/repos/flutter/flutter/events');
      expect(item.assigneesUrl,
          'https://api.github.com/repos/flutter/flutter/assignees{/user}');
      expect(item.branchesUrl,
          'https://api.github.com/repos/flutter/flutter/branches{/branch}');
      expect(item.tagsUrl, 'https://api.github.com/repos/flutter/flutter/tags');
      expect(item.blobsUrl,
          'https://api.github.com/repos/flutter/flutter/git/blobs{/sha}');
      expect(item.gitTagsUrl,
          'https://api.github.com/repos/flutter/flutter/git/tags{/sha}');
      expect(item.gitRefsUrl,
          'https://api.github.com/repos/flutter/flutter/git/refs{/sha}');
      expect(item.treesUrl,
          'https://api.github.com/repos/flutter/flutter/git/trees{/sha}');
      expect(item.statusesUrl,
          'https://api.github.com/repos/flutter/flutter/statuses/{sha}');
      expect(item.languagesUrl,
          'https://api.github.com/repos/flutter/flutter/languages');
      expect(item.stargazersUrl,
          'https://api.github.com/repos/flutter/flutter/stargazers');
      expect(item.contributorsUrl,
          'https://api.github.com/repos/flutter/flutter/contributors');
      expect(item.subscribersUrl,
          'https://api.github.com/repos/flutter/flutter/subscribers');
      expect(item.subscriptionUrl,
          'https://api.github.com/repos/flutter/flutter/subscription');
      expect(item.commitsUrl,
          'https://api.github.com/repos/flutter/flutter/commits{/sha}');
      expect(item.gitCommitsUrl,
          'https://api.github.com/repos/flutter/flutter/git/commits{/sha}');
      expect(item.commentsUrl,
          'https://api.github.com/repos/flutter/flutter/comments{/number}');
      expect(item.issueCommentUrl,
          'https://api.github.com/repos/flutter/flutter/issues/comments{/number}');
      expect(item.contentsUrl,
          'https://api.github.com/repos/flutter/flutter/contents/{+path}');
      expect(item.compareUrl,
          'https://api.github.com/repos/flutter/flutter/compare/{base}...{head}');
      expect(item.mergesUrl,
          'https://api.github.com/repos/flutter/flutter/merges');
      expect(item.archiveUrl,
          'https://api.github.com/repos/flutter/flutter/{archive_format}{/ref}');
      expect(item.downloadsUrl,
          'https://api.github.com/repos/flutter/flutter/downloads');
      expect(item.issuesUrl,
          'https://api.github.com/repos/flutter/flutter/issues{/number}');
      expect(item.pullsUrl,
          'https://api.github.com/repos/flutter/flutter/pulls{/number}');
      expect(item.milestonesUrl,
          'https://api.github.com/repos/flutter/flutter/milestones{/number}');
      expect(item.notificationsUrl,
          'https://api.github.com/repos/flutter/flutter/notifications{?since,all,participating}');
      expect(item.labelsUrl,
          'https://api.github.com/repos/flutter/flutter/labels{/name}');
      expect(item.releasesUrl,
          'https://api.github.com/repos/flutter/flutter/releases{/id}');
      expect(item.deploymentsUrl,
          'https://api.github.com/repos/flutter/flutter/deployments');
      expect(item.createdAt, '2015-03-06T22:54:58Z');
      expect(item.updatedAt, '2024-10-13T20:56:50Z');
      expect(item.pushedAt, '2024-10-13T20:56:54Z');
      expect(item.gitUrl, 'git://github.com/flutter/flutter.git');
      expect(item.sshUrl, 'git@github.com:flutter/flutter.git');
      expect(item.cloneUrl, 'https://github.com/flutter/flutter.git');
      expect(item.svnUrl, 'https://github.com/flutter/flutter');
      expect(item.homepage, 'https://flutter.dev');
      expect(item.size, 168067);
      expect(item.stargazersCount, 165427);
      expect(item.watchersCount, 165427);
      expect(item.language, 'Dart');
      expect(item.hasIssues, true);
      expect(item.hasProjects, true);
      expect(item.hasDownloads, true);
      expect(item.hasWiki, true);
      expect(item.hasPages, false);
      expect(item.hasDiscussions, false);
      expect(item.forksCount, 27304);
      expect(item.mirrorUrl, null);
      expect(item.archived, false);
      expect(item.disabled, false);
      expect(item.openIssuesCount, 12695);
      expect(item.license, license);
      expect(item.allowForking, true);
      expect(item.isTemplate, false);
      expect(item.webCommitSignoffRequired, false);
      expect(item.topics.length, 19);
      expect(item.visibility, 'public');
      expect(item.forks, 27304);
      expect(item.openIssues, 12695);
      expect(item.watchers, 165427);
      expect(item.defaultBranch, 'master');
      expect(item.score, 1.0);
    });

    test('2. JSONからクラスを作成し、Jsonに変換して内容を確認', () {
      final jsonString = '''
      {
        "total_count": 750330,
        "incomplete_results": false,
        "items": [
          {
            "id": 31792824,
            "node_id": "MDEwOlJlcG9zaXRvcnkzMTc5MjgyNA==",
            "name": "flutter",
            "full_name": "flutter/flutter",
            "private": false,
            "owner": {
              "login": "flutter",
              "id": 14101776,
              "node_id": "MDEyOk9yZ2FuaXphdGlvbjE0MTAxNzc2",
              "avatar_url": "https://avatars.githubusercontent.com/u/14101776?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/flutter",
              "html_url": "https://github.com/flutter",
              "followers_url": "https://api.github.com/users/flutter/followers",
              "following_url": "https://api.github.com/users/flutter/following{/other_user}",
              "gists_url": "https://api.github.com/users/flutter/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/flutter/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/flutter/subscriptions",
              "organizations_url": "https://api.github.com/users/flutter/orgs",
              "repos_url": "https://api.github.com/users/flutter/repos",
              "events_url": "https://api.github.com/users/flutter/events{/privacy}",
              "received_events_url": "https://api.github.com/users/flutter/received_events",
              "type": "Organization",
              "site_admin": false
            },
            "html_url": "https://github.com/flutter/flutter",
            "description": "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
            "fork": false,
            "url": "https://api.github.com/repos/flutter/flutter",
            "forks_url": "https://api.github.com/repos/flutter/flutter/forks",
            "keys_url": "https://api.github.com/repos/flutter/flutter/keys{/key_id}",
            "collaborators_url": "https://api.github.com/repos/flutter/flutter/collaborators{/collaborator}",
            "teams_url": "https://api.github.com/repos/flutter/flutter/teams",
            "hooks_url": "https://api.github.com/repos/flutter/flutter/hooks",
            "issue_events_url": "https://api.github.com/repos/flutter/flutter/issues/events{/number}",
            "events_url": "https://api.github.com/repos/flutter/flutter/events",
            "assignees_url": "https://api.github.com/repos/flutter/flutter/assignees{/user}",
            "branches_url": "https://api.github.com/repos/flutter/flutter/branches{/branch}",
            "tags_url": "https://api.github.com/repos/flutter/flutter/tags",
            "blobs_url": "https://api.github.com/repos/flutter/flutter/git/blobs{/sha}",
            "git_tags_url": "https://api.github.com/repos/flutter/flutter/git/tags{/sha}",
            "git_refs_url": "https://api.github.com/repos/flutter/flutter/git/refs{/sha}",
            "trees_url": "https://api.github.com/repos/flutter/flutter/git/trees{/sha}",
            "statuses_url": "https://api.github.com/repos/flutter/flutter/statuses/{sha}",
            "languages_url": "https://api.github.com/repos/flutter/flutter/languages",
            "stargazers_url": "https://api.github.com/repos/flutter/flutter/stargazers",
            "contributors_url": "https://api.github.com/repos/flutter/flutter/contributors",
            "subscribers_url": "https://api.github.com/repos/flutter/flutter/subscribers",
            "subscription_url": "https://api.github.com/repos/flutter/flutter/subscription",
            "commits_url": "https://api.github.com/repos/flutter/flutter/commits{/sha}",
            "git_commits_url": "https://api.github.com/repos/flutter/flutter/git/commits{/sha}",
            "comments_url": "https://api.github.com/repos/flutter/flutter/comments{/number}",
            "issue_comment_url": "https://api.github.com/repos/flutter/flutter/issues/comments{/number}",
            "contents_url": "https://api.github.com/repos/flutter/flutter/contents/{+path}",
            "compare_url": "https://api.github.com/repos/flutter/flutter/compare/{base}...{head}",
            "merges_url": "https://api.github.com/repos/flutter/flutter/merges",
            "archive_url": "https://api.github.com/repos/flutter/flutter/{archive_format}{/ref}",
            "downloads_url": "https://api.github.com/repos/flutter/flutter/downloads",
            "issues_url": "https://api.github.com/repos/flutter/flutter/issues{/number}",
            "pulls_url": "https://api.github.com/repos/flutter/flutter/pulls{/number}",
            "milestones_url": "https://api.github.com/repos/flutter/flutter/milestones{/number}",
            "notifications_url": "https://api.github.com/repos/flutter/flutter/notifications{?since,all,participating}",
            "labels_url": "https://api.github.com/repos/flutter/flutter/labels{/name}",
            "releases_url": "https://api.github.com/repos/flutter/flutter/releases{/id}",
            "deployments_url": "https://api.github.com/repos/flutter/flutter/deployments",
            "created_at": "2015-03-06T22:54:58Z",
            "updated_at": "2024-10-13T20:56:50Z",
            "pushed_at": "2024-10-13T20:56:54Z",
            "git_url": "git://github.com/flutter/flutter.git",
            "ssh_url": "git@github.com:flutter/flutter.git",
            "clone_url": "https://github.com/flutter/flutter.git",
            "svn_url": "https://github.com/flutter/flutter",
            "homepage": "https://flutter.dev",
            "size": 168067,
            "stargazers_count": 165427,
            "watchers_count": 165427,
            "language": "Dart",
            "has_issues": true,
            "has_projects": true,
            "has_downloads": true,
            "has_wiki": true,
            "has_pages": false,
            "has_discussions": false,
            "forks_count": 27304,
            "mirror_url": null,
            "archived": false,
            "disabled": false,
            "open_issues_count": 12695,
            "license": {
              "key": "bsd-3-clause",
              "name": "BSD 3-Clause \\"New\\" or \\"Revised\\" License",
              "spdx_id": "BSD-3-Clause",
              "url": "https://api.github.com/licenses/bsd-3-clause",
              "node_id": "MDc6TGljZW5zZTU="
            },
            "allow_forking": true,
            "is_template": false,
            "web_commit_signoff_required": false,
            "topics": [
              "android",
              "app-framework",
              "cross-platform",
              "dart",
              "dart-platform",
              "desktop",
              "flutter",
              "flutter-package",
              "fuchsia",
              "ios",
              "linux-desktop",
              "macos",
              "material-design",
              "mobile",
              "mobile-development",
              "skia",
              "web",
              "web-framework",
              "windows"
            ],
            "visibility": "public",
            "forks": 27304,
            "open_issues": 12695,
            "watchers": 165427,
            "default_branch": "master",
            "score": 1.0
          }
        ]
      }
      ''';

      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final data = GithubSearchRepositoriesData.fromJson(jsonMap);

      final toJsonMap = data.toJson();
      final expectedJsonMap = jsonMap;

      expect(toJsonMap, expectedJsonMap);
    });
  });
}
