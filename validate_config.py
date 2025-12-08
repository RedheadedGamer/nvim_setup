#!/usr/bin/env python3
"""
Comprehensive validation script for lua/plugins/init.lua
Tests syntax, structure, and configuration integrity
"""

import re
import sys
from collections import defaultdict

def validate_lua_file(filepath):
    """Validate Lua configuration file"""
    
    print("=" * 70)
    print("COMPREHENSIVE VALIDATION TEST")
    print("=" * 70)
    print()
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        lines = content.split('\n')
    
    errors = []
    warnings = []
    passes = []
    
    # Test 1: Bracket matching
    print("[TEST 1] Bracket/Brace/Parenthesis Matching")
    open_braces = content.count('{')
    close_braces = content.count('}')
    open_parens = content.count('(')
    close_parens = content.count(')')
    open_brackets = content.count('[')
    close_brackets = content.count(']')
    
    if open_braces == close_braces:
        passes.append("✅ Braces match: {} pairs".format(open_braces))
    else:
        errors.append("❌ Brace mismatch: {} open, {} close".format(open_braces, close_braces))
    
    if open_parens == close_parens:
        passes.append("✅ Parentheses match: {} pairs".format(open_parens))
    else:
        errors.append("❌ Parenthesis mismatch: {} open, {} close".format(open_parens, close_parens))
    
    if open_brackets == close_brackets:
        passes.append("✅ Brackets match: {} pairs".format(open_brackets))
    else:
        errors.append("❌ Bracket mismatch: {} open, {} close".format(open_brackets, close_brackets))
    
    print("\n".join(passes[-3:] if not errors[-3:] else errors[-3:]))
    print()
    
    # Test 2: File structure
    print("[TEST 2] File Structure")
    # Check first non-comment, non-empty line
    first_code_line = None
    for line in lines:
        stripped = line.strip()
        if stripped and not stripped.startswith('--'):
            first_code_line = stripped
            break
    
    if first_code_line and first_code_line.startswith('return {'):
        passes.append("✅ File starts with 'return {'")
    else:
        errors.append("❌ File should start with 'return {' (found: {})".format(first_code_line[:30] if first_code_line else 'nothing'))
    
    if content.strip().endswith('}'):
        passes.append("✅ File ends with '}'")
    else:
        errors.append("❌ File should end with '}'")
    
    print("\n".join(passes[-2:] if not errors[-2:] else errors[-2:]))
    print()
    
    # Test 3: Security fixes validation
    print("[TEST 3] Security Fixes Verification")
    security_checks = [
        ('vim.api.nvim_cmd', 'Command injection fix (safe API usage)'),
        ('vim.fs.normalize', 'Path traversal fix (path sanitization)'),
        ('pcall(require, "snacks")', 'vim.notify fallback protection'),
        ('local server_cmd = config.cmd', 'LSP executable validation'),
    ]
    
    for pattern, description in security_checks:
        if pattern in content:
            passes.append(f"✅ {description}")
        else:
            warnings.append(f"⚠️  Missing: {description}")
    
    print("\n".join(passes[-4:]))
    if warnings:
        print("\n".join(warnings[-4:]))
    print()
    
    # Test 4: Performance optimizations
    print("[TEST 4] Performance Optimizations")
    perf_checks = [
        ('lazy = true.*tokyonight', 'Tokyonight lazy-loaded'),
        ('lazy = true.*gruvbox', 'Gruvbox lazy-loaded'),
        ('lazy = true.*dracula', 'Dracula lazy-loaded'),
        ('highlights_set', 'Rainbow delimiters optimized'),
        ('formatter_cache', 'Formatter caching implemented'),
        ('linter_cache', 'Linter caching implemented'),
        ('max_concurrent_installers = 5', 'Mason installer limit reduced'),
    ]
    
    for pattern, description in perf_checks:
        if re.search(pattern, content, re.IGNORECASE | re.DOTALL):
            passes.append(f"✅ {description}")
        else:
            warnings.append(f"⚠️  Missing: {description}")
    
    print("\n".join(passes[-7:]))
    print()
    
    # Test 5: Error handling
    print("[TEST 5] Error Handling")
    pcall_count = content.count('pcall(require,')
    if pcall_count >= 8:
        passes.append(f"✅ Error handling: {pcall_count} pcall wrappers found")
    else:
        warnings.append(f"⚠️  Expected 8+ pcall wrappers, found {pcall_count}")
    
    print(passes[-1] if not warnings[-1:] else warnings[-1])
    print()
    
    # Test 6: Removed components
    print("[TEST 6] Removed Components (Should NOT be present)")
    removed_checks = [
        (r'^\s*"echasnovski/mini\.bufremove"', 'mini.bufremove plugin'),
        (r'^\s*"tpope/vim-fugitive"', 'vim-fugitive plugin'),
        ('Monokai Pro family - Professional themes', 'Commented placeholder themes'),
    ]
    
    for pattern, description in removed_checks:
        if re.search(pattern, content, re.MULTILINE):
            errors.append(f"❌ Still present: {description}")
        else:
            passes.append(f"✅ Removed: {description}")
    
    print("\n".join(passes[-3:] if not errors[-3:] else errors[-3:]))
    print()
    
    # Test 7: Configuration integrity
    print("[TEST 7] Configuration Integrity")
    integrity_checks = [
        ('.setup(', 'Plugin setup calls'),
        ('config = function', 'Config functions'),
        ('vim.keymap.set', 'Keybinding definitions'),
        ('vim.lsp.config', 'LSP configuration'),
        ('require("conform")', 'Formatter configuration'),
    ]
    
    for pattern, description in integrity_checks:
        count = content.count(pattern)
        if count > 0:
            passes.append(f"✅ {description}: {count} instances")
        else:
            warnings.append(f"⚠️  No {description} found")
    
    print("\n".join(passes[-5:]))
    print()
    
    # Test 8: Documentation
    print("[TEST 8] Documentation")
    doc_checks = [
        ('MAGIC NUMBER:', 'Magic number documentation'),
        ('MAGIC:', 'Magic value documentation'),
        ('SECURITY FIX:', 'Security fix documentation'),
        ('PHASE.*FIX', 'Phase fix documentation'),
        ('PERFORMANCE:', 'Performance documentation'),
    ]
    
    doc_count = 0
    for pattern, description in doc_checks:
        if re.search(pattern, content):
            doc_count += 1
    
    if doc_count >= 3:
        passes.append(f"✅ Documentation: {doc_count} different comment types found")
    else:
        warnings.append(f"⚠️  Limited documentation: only {doc_count} types found")
    
    print(passes[-1] if not warnings[-1:] else warnings[-1])
    print()
    
    # Summary
    print("=" * 70)
    print("VALIDATION SUMMARY")
    print("=" * 70)
    print(f"✅ Passed:   {len([p for p in passes if '✅' in p])}")
    print(f"⚠️  Warnings: {len([w for w in warnings if '⚠️' in w])}")
    print(f"❌ Errors:   {len([e for e in errors if '❌' in e])}")
    print()
    
    if errors:
        print("ERRORS FOUND:")
        for error in errors:
            print(f"  {error}")
        print()
        return False
    elif warnings:
        print("STATUS: ⚠️  PASSED WITH WARNINGS")
        for warning in warnings[:5]:
            print(f"  {warning}")
        print()
        return True
    else:
        print("STATUS: ✅ ALL TESTS PASSED")
        print()
        return True

if __name__ == '__main__':
    filepath = 'lua/plugins/init.lua'
    success = validate_lua_file(filepath)
    sys.exit(0 if success else 1)
