import dataclasses
import functools
from collections.abc import Collection, Iterator
from pathlib import Path

from fastwalk import _core  # ty: ignore[unresolved-import]

PathLike = Path | str


@dataclasses.dataclass(frozen=True)
class DirEntry:
    _core_entry: _core.DirEntry

    @functools.cached_property
    def path(self) -> Path:
        # TODO
        ...

    @functools.cached_property
    def path_str(self) -> str:
        # TODO
        ...

    @functools.cached_property
    def is_file(self) -> bool:
        # TODO
        ...

    @functools.cached_property
    def is_dir(self) -> bool:
        # TODO
        ...

    @functools.cached_property
    def is_symlink(self) -> bool:
        # TODO
        ...


def walk(
    root: PathLike,
    *,
    filters: Collection[str] = (),  # Glob patterns ("any of" semantics).
    ignore_dirs: Collection[PathLike] = (),  # Absolute, or relative to `root`.
    ignore_hidden: bool = True,
    respect_git_ignore: bool = True,
    respect_global_git_ignore: bool = True,
    respect_git_exclude: bool = True,
    respect_ignore: bool = True,
    follow_symlinks: bool = False,
    max_depth: int | None = None,
    min_depth: int | None = None,
    max_filesize: int | None = None,
    threads: int = 0,
) -> Iterator[DirEntry]:
    # TODO
    # - Implement this function, calling rust via _core.
    # - Use the `ignore` crate in rust to implement this.
    # - Use `WalkBuilder.build_parallel` to use multiple threads.
    # - Use the `crossbeam` crate to create a channel for sending the results back to python.
    # - Think about correct error handling and optimal performance.
    ...
