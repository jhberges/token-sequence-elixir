[
  mappings: [
    "logger.console.level": [
      doc: "Provide documentation for logger.console.level here.",
      to: "logger.console.level",
      datatype: :atom,
      default: :info
    ],
    "logger.console.format": [
      doc: "Provide documentation for logger.console.format here.",
      to: "logger.console.format",
      datatype: :binary,
      default: """
      $date $time [$level] $metadata$message
      """
    ],
    "logger.console.metadata": [
      doc: "Provide documentation for logger.console.metadata here.",
      to: "logger.console.metadata",
      datatype: [
        list: :atom
      ],
      default: [
        :user_id
      ]
    ],
    "redis.hostname": [
      doc: "Provide documentation for redis.hostname here.",
      to: "redis.hostname",
      datatype: :binary,
      default: "localhost"
    ],
    "redis.port": [
      doc: "Provide documentation for redis.port here.",
      to: "redis.port",
      datatype: :integer,
      default: 6379
    ],
    "redis.database": [
      doc: "Provide documentation for redis.database here.",
      to: "redis.database",
      datatype: :integer,
      default: 0
    ],
    "redis.password": [
      doc: "Provide documentation for redis.password here.",
      to: "redis.password",
      datatype: :binary,
      default: ""
    ],
    "urna.http_port": [
      doc: "Provide documentation for urna.http_port here.",
      to: "urna.http_port",
      datatype: :integer,
      default: 9100
    ]
  ],
  translations: [
  ]
]