//
//  SwiftLintPlugin.swift
//
//
//  Created by Nikolay Komissarov on 20.10.2022.
//

import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    return [

        .buildCommand(
            displayName: "Running SwiftLint for \(target.name)",
            executable: try context.tool(named: "swiftlint").path,
            arguments: [
                "lint",
                "--in-process-sourcekit",
                "--path",
                target.directory.string,
                "--config",
                "\(context.package.directory.string)/.swiftlint.yml"
            ],
            environment: [:]
        )
    ]
  }
}
