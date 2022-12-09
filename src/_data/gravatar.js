const crypto = require("crypto");
const EleventyFetch = require("@11ty/eleventy-fetch");

module.exports = async function () {
  const email = process.env.EMAIL;

  if (!email) {
    return {};
  }

  const sanitisedEmail = email.trim().toLowerCase();
  const emailHash = crypto
    .createHash("md5")
    .update(sanitisedEmail)
    .digest("hex");

  try {
    let gravatarData = await EleventyFetch(
      `${process.env.GRAVATAR_API_URI}/${emailHash}.json`,
      {
        duration: "1d",
        type: "json",
      }
    );

    // console.log(gravatarData.entry[0]);
    return gravatarData.entry[0];
  } catch (e) {
    console.error("Failed getting Gravatar details, returning fallback data");
    return {
      // TODO populate some of these
      sensibleDefaults: 0,
    };
  }
};
