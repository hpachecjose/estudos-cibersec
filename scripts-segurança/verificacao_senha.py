"""
Password Security Validator
Autor: Profissional de Segurança da Informação

Objetivo:
Validar a robustez de uma senha com base em boas práticas modernas de segurança,
reduzindo riscos de ataques como força bruta, dicionário e reutilização previsível.

Observações de segurança:
- A senha NÃO é armazenada.
- Nenhum log sensível é gerado.
- O código evita comparações inseguras.
"""

import re
import secrets
import string
from dataclasses import dataclass
from typing import List


@dataclass(frozen=True)
class PasswordPolicy:
    """Define a política de segurança para validação de senhas."""
    min_length: int = 12
    require_uppercase: bool = True
    require_lowercase: bool = True
    require_digits: bool = True
    require_special: bool = True
    forbidden_sequences: List[str] = (
        "1234",
        "abcd",
        "password",
        "senha",
        "qwerty",
    )


class PasswordValidator:
    """Responsável por validar senhas de acordo com a política definida."""

    SPECIAL_CHARS = string.punctuation

    def __init__(self, policy: PasswordPolicy):
        self.policy = policy

    def validate(self, password: str) -> List[str]:
        """Valida a senha e retorna uma lista de falhas encontradas."""
        errors = []

        if len(password) < self.policy.min_length:
            errors.append(
                f"A senha deve conter no mínimo {self.policy.min_length} caracteres."
            )

        if self.policy.require_uppercase and not re.search(r"[A-Z]", password):
            errors.append("A senha deve conter ao menos uma letra maiúscula.")

        if self.policy.require_lowercase and not re.search(r"[a-z]", password):
            errors.append("A senha deve conter ao menos uma letra minúscula.")

        if self.policy.require_digits and not re.search(r"\d", password):
            errors.append("A senha deve conter ao menos um número.")

        if self.policy.require_special and not any(
            char in self.SPECIAL_CHARS for char in password
        ):
            errors.append("A senha deve conter ao menos um caractere especial.")

        lowered_password = password.lower()
        for seq in self.policy.forbidden_sequences:
            if seq in lowered_password:
                errors.append("A senha contém sequências previsíveis ou comuns.")
                break

        return errors


def generate_secure_password(length: int = 16) -> str:
    """
    Gera uma senha forte usando fontes criptograficamente seguras.
    Ideal para sugerir senhas ao usuário.
    """
    if length < 12:
        raise ValueError("O comprimento mínimo recomendado é 12 caracteres.")

    alphabet = (
        string.ascii_lowercase
        + string.ascii_uppercase
        + string.digits
        + string.punctuation
    )

    return "".join(secrets.choice(alphabet) for _ in range(length))


def main() -> None:
    """Fluxo principal da aplicação."""
    policy = PasswordPolicy()
    validator = PasswordValidator(policy)

    print("Validador de Senhas Seguras\n")
    password = input("Digite a senha a ser avaliada: ")

    violations = validator.validate(password)

    if violations:
        print("\nSenha FRACA ❌")
        for error in violations:
            print(f"- {error}")
    else:
        print("\nSenha FORTE ✅")

    print("\nSugestão de senha segura:")
    print(generate_secure_password())


if __name__ == "__main__":
    main()

