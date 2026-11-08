// Closes the issues a merged pull request says it fixes, for pull requests into a branch other than the
// default one (GitHub only does this itself for the default branch). Same keywords as GitHub:
// close, closes, closed, fix, fixes, fixed, resolve, resolves, resolved, each followed by one issue:
// "Fixes #12", "fixes: #12", "Fixes owner/repo#12" or "Fixes https://github.com/owner/repo/issues/12".
// Used by .github/workflows/close-fixed-issues.yml through actions/github-script.

const KEYWORD = String.raw`\b(?:close[sd]?|fix(?:e[sd])?|resolve[sd]?)\b:?\s+`;
const TARGET = String.raw`(?:#(\d+)|([\w.-]+)/([\w.-]+)#(\d+)|https?://github\.com/([\w.-]+)/([\w.-]+)/issues/(\d+))\b`;

function findFixedIssues(text, owner, repo) {
  const re = new RegExp(KEYWORD + TARGET, 'gi');
  const same = (o, r) => o.toLowerCase() === owner.toLowerCase() && r.toLowerCase() === repo.toLowerCase();
  const found = new Set();
  for (const m of text.matchAll(re)) {
    if (m[1]) found.add(Number(m[1]));
    else if (m[4] && same(m[2], m[3])) found.add(Number(m[4]));
    else if (m[7] && same(m[5], m[6])) found.add(Number(m[7]));
  }
  return [...found].sort((a, b) => a - b);
}

async function run({ github, context, core, dryRun = false }) {
  const pr = context.payload.pull_request;
  const { owner, repo } = context.repo;
  if (!pr || !pr.merged) return core.info('Not a merged pull request.');
  if (pr.base.ref === context.payload.repository.default_branch) {
    return core.info(`Merged into the default branch (${pr.base.ref}): GitHub closes the issues itself.`);
  }

  const texts = [pr.body || ''];
  const commits = await github.paginate(github.rest.pulls.listCommits, { owner, repo, pull_number: pr.number, per_page: 100 });
  for (const c of commits) texts.push(c.commit.message);
  const numbers = findFixedIssues(texts.join('\n'), owner, repo);
  if (numbers.length === 0) return core.info(`#${pr.number} names no issue it fixes.`);

  for (const n of numbers) {
    let issue;
    try {
      issue = (await github.rest.issues.get({ owner, repo, issue_number: n })).data;
    } catch (e) {
      core.warning(`#${n}: ${e.message}`);
      continue;
    }
    if (issue.pull_request) { core.info(`#${n} is a pull request, left alone.`); continue; }
    if (issue.state === 'closed') { core.info(`#${n} is already closed.`); continue; }
    if (dryRun) { core.info(`would close #${n} (${issue.title})`); continue; }
    await github.rest.issues.createComment({
      owner, repo, issue_number: n,
      body: `Fixed by #${pr.number}, merged into \`${pr.base.ref}\`.`,
    });
    await github.rest.issues.update({ owner, repo, issue_number: n, state: 'closed', state_reason: 'completed' });
    core.info(`closed #${n} (${issue.title})`);
  }
}

module.exports = run;
module.exports.findFixedIssues = findFixedIssues;
