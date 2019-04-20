require "securerandom"
require "time"
SecureRandom.uuid

sources = [
  "the-camper-kit",
  "twitter",
  "facebook",
  "bunum-wo-aa-papua-new-guinea",
  "the-cold-brew-kit",
  "instagram",
  "browse-kits",
  "about",
  "msr-reactor-2.5l-stove-system",
  "contact-us",
  "browse-products",
  "areopress-coffee-maker",
  "support",
  "the-pour-over-kit",
  "the-french-press-kit",
  "chemex-classic-6-cup-coffee-maker",
  "the-chemex-kit"
]

devices = [
  "mobile",
  "desktop",
  "laptop",
  "IoT",
  "Smartwatch"
]

agents = [
  "firefox",
  "chrome",
  "edge",
  "safari",
  "curl"
]

prng = Random.new

sources.
  flat_map do |source|
    prng.rand(20).times.map do
      [
        SecureRandom.uuid,
        source,
        (Time.now - (prng.rand(30) * 60 * 60 * 24)).iso8601(0),
        prng.rand(1..10).to_s
      ]
    end
  end.
  map do |entry|
    "INSERT INTO button_click(\"uuid\", button_id, created_date, clicks) VALUES ('#{entry[0]}', '#{entry[1]}', '#{entry[2]}', '#{entry[3]}');\n"
  end.
  each do |entry|
    print entry
  end

agents.
  flat_map do |agent|
    prng.rand(20).times.map do
      [
        SecureRandom.uuid,
        devices.sample,
        agent,
        (Time.now - (prng.rand(30) * 60 * 60 * 24)).iso8601(0),
        prng.rand(1..10).to_s
      ]
    end
  end.
  map do |entry|
    "INSERT INTO page_load(\"uuid\", user_device_type, user_agent, created_date, loads) VALUES ('#{entry[0]}', '#{entry[1]}', '#{entry[2]}', '#{entry[3]}', '#{entry[4]}');\n"
  end.
  each do |entry|
    print entry
  end
