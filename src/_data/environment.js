module.exports = function () {
  return {
    email: process.env.EMAIL || "",
    versionName: process.env.SITE_VERSION_NAME || "local_development",
    versionLink:
      process.env.SITE_VERSION_LINK ||
      "https://github.com/danielemery/demery-home",
  };
};
