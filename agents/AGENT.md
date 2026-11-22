@office.md

# Development Guidelines

## TypeScript

- MUST read and follow the `ts-convention` skill before creating, modifying, or reviewing any `.ts` or `.tsx` files.
- MUST use the `ts-fp` skill when modeling fallible operations or optional values with `Result` or `Option`
- MUST follow `ts-convention` rule 4 (braces), regardless of the surrounding repository style.

## Version Control

- Use Jujutsu (`jj`) instead of Git CLI.
- If the repository has no `.jj` directory, ask for permission before running `jj git init --colocate`.
- Never initialize or modify repository version control without confirmation.

## Pull Requests

- Assign every newly created PR to yourself by default.

## Language

- Use Korean for all explanations and responses by default.
- Keep code, identifiers, and technical terms in their original English.
- Write code comments and documentation in Korean unless requested otherwise.

## Git Conventions

- Prefer following the Conventional Commits specification when writing commit messages.
- Keep commit messages concise and focused.
