module.exports = function () {
  return {
    email: process.env.EMAIL || "",
    gitFullCommitHash: process.env.GIT_COMMIT_HASH || "local_development",
    gitShortCommitHash: process.env.GIT_COMMIT_HASH || "local_development",
  };
};
